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

local stageFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	stageFrame = "special"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then stageFrame = "special" end
if GAMESTATE:IsAnExtraStage() then stageFrame = "extra" end

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(stageFrame..suffix,1,true) then
	stageFrame = stageFrame .. suffix
else
	Warn("ScreenGameplay StageFrame: missing frame \""..stageFrame..suffix.."\". Using fallback assets.")
	stageFrame = stageFrame.." standard"
end

return Def.ActorFrame{ LoadActor(stageFrame) };