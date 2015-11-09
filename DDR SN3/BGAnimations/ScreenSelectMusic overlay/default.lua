--Explanation of these values:
--The game seems to treat every BPM below about 100 and above about 270 exactly the same.
--115 is about the lowest BPM where there will always be showing bar pieces.
--This is not necessarily true at 100 BPM, so a negative value is generated.
--155 is simply 270-115, the spread between 0 and 1. - tertu
local function CalculateBaseForBPM(bpm)
	return 1 - (clamp(bpm, 100, 300) - 115) / 155
end

local function UpdateBPMGauge(self)
	local maximumTwiddleDistance = 13/86
	--13/86 was chosen because it's roughly the height of two bar pieces -tertu
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
				crop = clamp(crop - (math.random() * maximumTwiddleDistance), 0, 1)
				gauge:croptop(crop)
			elseif not (song:IsDisplayBpmSecret() or song:IsDisplayBpmRandom()) then
				--This song has two display BPMs: read the current BPM off the BPMDisplay
				gauge:finishtweening()
				local bpmDisplay = SCREENMAN:GetTopScreen():GetChild("BPMDisplay")
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
			self:hibernate(1.25):draworder(101):x(SCREEN_LEFT+76):y(SCREEN_CENTER_Y-5):visible(false)
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
	LoadActor("SNDifficultyList.lua");
	LoadActor("labels")..{
		InitCommand=cmd(x,SCREEN_LEFT+201;y,SCREEN_CENTER_Y+7);
		OnCommand=cmd(draworder,2;diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
		OffCOmmand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
	Def.Sprite {
	Texture="WheelEffect 5x4",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y-16.5)
			self:SetAllStateDelays(0.04)
		end,
		OnCommand=function(self)
			self:addx(380):sleep(0.264):sleep(0.558):decelerate(0.231):addx(-380)
		end,
		OffCommand=function(self)
			self:accelerate(0.396):addx(380)
		end
	};
	Def.Sprite {
	Texture="help 1x3.png",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_RIGHT-200):y(SCREEN_BOTTOM-33.5)
			self:SetAllStateDelays(4.224)
		end,
		OnCommand=function(self)
			self:addy(54):sleep(0.2):decelerate(0.2):addy(-54)
		end,
		OffCommand=function(self)
			self:decelerate(0.2);addy(54)
		end
	};
};

return t;