return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/_bck"))..{
		InitCommand=cmd(Center;FullScreen);
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0)
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
		InitCommand=cmd(FullScreen;diffuse,color("#14fc00"));
		OnCommand=cmd(diffusealpha,0.2);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0)
	};
	LoadActor(THEME:GetPathB("","ScreenWithMenuElements background/honeyright"))..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;CenterY;zoomtoheight,SCREEN_HEIGHT);
		OnCommand=cmd(diffusealpha,0.2);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0)
	};
	LoadActor("werds")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0)
	};
	LoadActor("bemani")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;sleep,5.165;linear,0.165;diffusealpha,1);
		OffCommand=cmd(sleep,10.165;linear,0.165;diffusealpha,0);
	};
}
