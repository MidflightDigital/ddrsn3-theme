local eState = (GAMESTATE:Env()).EndlessState

return Def.ActorFrame{
	OffCommand=function(s) eState.life = SCREENMAN:GetTopScreen()
	:GetPlayerInfo(GAMESTATE:GetMasterPlayerNumber())
	:GetLifeMeter():GetLife() end;
	LoadActor("ScreenGameplay out");
}