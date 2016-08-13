local env = GAMESTATE:Env()

local function LoadLife()
	if env.EndlessState.life then
		local playerName = "Player"..ToEnumShortString(GAMESTATE:GetMasterPlayerNumber())
		local player = SCREENMAN:GetTopScreen():GetChild(playerName)
		player:SetLife(env.EndlessState.life)
	end
end

return Def.ActorFrame{
	LoadActor("ScreenGameplay in");
	Def.Actor{
		OnCommand=function() return LoadLife() end;
	}
};