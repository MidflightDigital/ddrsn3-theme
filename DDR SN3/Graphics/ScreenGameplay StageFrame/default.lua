local stageFrame = "normal"

if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "oni" end

return Def.ActorFrame{ LoadActor(stageFrame) };