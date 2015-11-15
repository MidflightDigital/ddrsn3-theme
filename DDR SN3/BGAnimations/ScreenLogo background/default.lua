return Def.ActorFrame{
	LoadActor("ddrsn_logobg")..{
		InitCommand=cmd(Center;FullScreen);
	};
	LoadActor("ddrsn_konami")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-2;y,SCREEN_BOTTOM-40);
	};
}