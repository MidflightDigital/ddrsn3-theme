--Explanation of these values:
--The game seems to treat every BPM below about 100 and above about 270 exactly the same.
--115 is about the lowest BPM where there will always be showing bar pieces.
--This is not necessarily true at 100 BPM, so a negative value is generated.
--155 is simply 270-115, the spread between 0 and 1. - tertu

--13/86 was chosen because it's roughly the height of two bar pieces -tertu
local twiddleDistance = 13/86

local function CalculateBaseForBPM(bpm)
	return 1 - (((clamp(bpm, 100, 300) - 100) / 140)+twiddleDistance/2)
end

local ScreenSelectMusic

local function UpdateBPMGauge(self)
	if not ScreenSelectMusic then
		local top = SCREENMAN:GetTopScreen()
		if top and top:GetChild("BPMDisplay") then
			ScreenSelectMusic = top
		else return end
	end
	local gauge = self:GetChild("bpm gauge bright")
	assert(gauge, "UpdateBPMGauge: Can't find the bright part of the BPM gauge.")
	if GAMESTATE then
		local song = GAMESTATE:GetCurrentSong()
		if song then
			--This function only handles the case where display BPM is constant.
			if song:IsDisplayBpmConstant() and not (song:IsDisplayBpmSecret() or song:IsDisplayBpmRandom()) then
				--This song has only one display BPM: show that value and randomly vibrate the tip around it
				--We have to finish tweening in case the last song was random
				gauge:finishtweening()
				local displayBpms = song:GetDisplayBpms()
				local displayBpm = displayBpms[1]
				local crop = CalculateBaseForBPM(displayBpm)
				crop = clamp(crop - ((math.random()-0.5) * twiddleDistance), 0, 1)
				gauge:croptop(crop)
			elseif not (song:IsDisplayBpmSecret() or song:IsDisplayBpmRandom()) then
				--This song has two display BPMs: read the current BPM off the BPMDisplay
				gauge:finishtweening()
				local bpmDisplay = ScreenSelectMusic:GetChild("BPMDisplay")
				gauge:croptop(clamp(CalculateBaseForBPM(tonumber(bpmDisplay:GetText()) or 0), 0, 1))
			else
				if gauge:GetTweenTimeLeft()==0 then
					--This song has a random display BPM: shoot the indicator all the way up and down rapidly
					--I use a command because it's really difficult to do timed things in UpdateFunctions
					gauge:playcommand("Random")
				end
			end
			return
		end
	end
	--that is, the gauge should show zero which I think is correct behavior
	gauge:croptop(1)
end

local t = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateBPMGauge) end,
	Def.Sprite {
	Name="bpm gauge bright",
	Texture="bpm gauge",
		InitCommand=function(self)
			self:hibernate(1.25):draworder(101):x(SCREEN_LEFT+75):y(SCREEN_CENTER_Y-1):visible(false)
		end,
		OnCommand=function(self)
			self:sleep(0.264):visible(true)
		end,
		OffCommand=function(self)
			self:sleep(0.033):accelerate(0.33):addx(-400)
		end,
		RandomCommand=function(self)
			self:croptop(1):linear(0.25):croptop(0):linear(0.25):croptop(1)
		end
	};
};

return t;