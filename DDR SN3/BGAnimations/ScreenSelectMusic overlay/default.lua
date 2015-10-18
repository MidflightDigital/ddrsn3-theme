--Explanation of these values:
--The game seems to treat every BPM below about 100 and above about 300 exactly the same.
--115 is about the lowest BPM where there will always be showing bar pieces.
--This is not necessarily true at 100 BPM, so a negative value is generated.
--185 is simply 300-115, the spread between 0 and 1. - tertu
local function CalculateBaseForBPM(bpm)
	return (clamp(bpm, 100, 300) - 115) / 185
end

local function TwiddleBPMGauge(self)
	local maximumTwiddleDistance = 13/86
	--13/86 was chosen because it's roughly the height of two bar pieces -tertu
	local gauge = self:GetChild("bpm gauge bright")
	assert(gauge, "TwiddleBPMGauge: Can't find the bright part of the BPM gauge.")
	if GAMESTATE then
		local song = GAMESTATE:GetCurrentSong()
		if song then
			--This function only handles the case where display BPM is constant.
			if song:IsDisplayBpmConstant() then
				--Just in case.
				gauge:finishtweening()
				local displayBpms = song:GetDisplayBpms()
				local displayBpm = displayBpms[1]
				local crop = CalculateBaseForBPM(displayBpm)
				crop = clamp(crop + (math.random() * maximumTwiddleDistance), 0, 1)
				gauge:croptop(crop)
			end
		end
	end
end




local t = Def.ActorFrame{

	Def.Sprite {
	Texture="bpm gauge",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_CENTER_X-244):y(SCREEN_CENTER_Y-5)
			self:diffuse(0.5,0.5,0.5)
		end,
		OnCommand=function(self)
			self:diffusealpha(0):sleep(0.6):draworder(50):diffusealpha(1)
		end
	};
	Def.Sprite {
	Name="bpm gauge bright",
	Texture="bpm gauge",
		InitCommand=function(self)
			self:draworder(101):x(SCREEN_CENTER_X-244):y(SCREEN_CENTER_Y-5)
		end,
		OnCommand=function(self)
			self:diffusealpha(0):sleep(0.6):draworder(50):diffusealpha(1)
		end
	};
};

return t;