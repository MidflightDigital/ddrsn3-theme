local env = GAMESTATE:Env()

if env.EndlessState.life then
	local playerName = "Player"..ToEnumShortString(GAMESTATE:GetMasterPlayerNumber())
	local player = SCREENMAN:GetTopScreen():GetChild(player)
	player:SetLife(env.EndlessState.life)
end

return Def.ActorFrame{
	LoadActor("ScreenGameplay in")
};