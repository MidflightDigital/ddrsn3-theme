local LoadingScreen = Var "LoadingScreen"
--smcmd is "screen metrics command", gmcmd is "general metrics command"
local smcmd, gmcmd
do
	smcmd = function(s, name)
		return (THEME:GetMetric(LoadingScreen, name))(s)
	end
	gmcmd = function(s, name)
		return (THEME:GetMetric("BPMDisplay", name))(s)
	end
end

local counter = 0
local targetDelta = 1/60
local timer = GetUpdateTimer(targetDelta)

local function RandomBPM(self, _)
	local s = self:GetChild"BPMDisplay"
	if not timer() then return end
	s:settext(string.rep(tostring(counter),3))
	counter = (counter+1)%10
end

local BPMFormat = "%03d"
local function textBPM(dispBPM)
	return string.format(BPMFormat, math.round(dispBPM))
end

local goingUp = true
local startTime = GetTimeSinceStart()
local dispBPMs = {0,0}
local length = 1
local pause = 1
local function VariedBPM(self, _)
	local s = self:GetChild"BPMDisplay"
	local curTime = GetTimeSinceStart()
	local base = dispBPMs[goingUp and 1 or 2]
	local target = dispBPMs[goingUp and 2 or 1]
	local bpm = clamp(base+(target-base)*((curTime-startTime)/length), 
		goingUp and base or target, 
		goingUp and target or base)
	s:aux(bpm):settext(textBPM(bpm))
	if curTime >= startTime + length + pause then
		goingUp = not goingUp
		startTime = curTime
	end
end


return Def.ActorFrame{
	Name="BPMDisplayHost",
	Def.BitmapText{
		Font="BPMDisplay bpm",
		Name="BPMDisplay",
		InitCommand=function(s) s:aux(0):halign(0):settext "000":x(THEME:GetMetric(LoadingScreen,"BPMDisplayX"))
			:y(THEME:GetMetric(LoadingScreen,"BPMDisplayY")); gmcmd(s, "SetNoBpmCommand") end,
		OnCommand=function(s) return smcmd(s, "BPMDisplayOnCommand") end,
		OffCommand=function(s) return smcmd(s, "BPMDisplayOffCommand") end,
		CurrentSongChangedMessageCommand = function(s, _)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				dispBPMs = song:GetDisplayBpms()
				if song:IsDisplayBpmRandom() or song:IsDisplayBpmSecret() then
					gmcmd(s, song:IsDisplayBpmRandom() and "SetRandomCommand" or "SetExtraCommand")
					counter = 0
					timer = GetUpdateTimer(targetDelta)
					s:aux(-1):settext "999":GetParent():SetUpdateFunction(RandomBPM)
				else
					s:aux(dispBPMs[1]):settext(textBPM(dispBPMs[1]))
					if song:IsDisplayBpmConstant() then
						gmcmd(s, "SetNormalCommand")
						s:GetParent():SetUpdateFunction(nil)
					else						
						gmcmd(s, "SetChangeCommand")
						goingUp = true
						startTime = GetTimeSinceStart()
						s:GetParent():SetUpdateFunction(VariedBPM)
					end
				end
			else
				gmcmd(s, "SetNoBpmCommand")
				s:aux(0):settext "000":GetParent():SetUpdateFunction(nil)
			end
		end
	}
}