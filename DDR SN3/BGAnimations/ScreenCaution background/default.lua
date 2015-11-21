return Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenWithMenuElements background/default.lua"));
	LoadActor("werds")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;linear,0.165;diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
}
