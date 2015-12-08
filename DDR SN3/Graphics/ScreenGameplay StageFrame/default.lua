-- gameplay life frame
local stageFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	stageFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then stageFrame = "rave" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then stageFrame = "extra" end

return Def.ActorFrame{ LoadActor(stageFrame) };
