-- gameplay life frame
local stageFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "rave" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "extra" end

return Def.ActorFrame{ LoadActor(stageFrame) };