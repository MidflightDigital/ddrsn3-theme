-- gameplay life frame
local stageFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	stageFrame = "special"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then stageFrame = "special" end
if GAMESTATE:IsAnExtraStage() then stageFrame = "extra" end

return Def.ActorFrame{ LoadActor(stageFrame) };