-- gameplay life frame

-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " standard",
	[math.floor(10000*16/9)] = " widescreen",
	[math.floor(10000*16/10)] = " widescreen"
}
--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

local lifeFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "extra" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "extra" end

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(lifeFrame..suffix,1,true) then
	lifeFrame = lifeFrame .. suffix
else
	Warn("ScreenGameplay LifeFrame: missing frame \""..lifeFrame..suffix.."\". Using fallback assets.")
	lifeFrame = lifeFrame.." standard"
end

local t = Def.ActorFrame{}
t[#t+1] = LoadActor("flicker")
t[#t+1] = LoadActor(lifeFrame)..{
		BeginCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:cropleft(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropright(0.5)
			end
		end;
};
	

return t
