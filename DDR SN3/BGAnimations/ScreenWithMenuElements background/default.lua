return Def.ActorFrame{
	LoadActor("ring5")..{
		InitCommand=cmd(FullScreen;diffuse,color("#14fc00"));
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/back"))..{
		InitCommand=cmd(FullScreen;diffusealpha,0.5);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
		InitCommand=cmd(FullScreen;diffuse,color("#14fc00");diffusealpha,0.2);
	};
	LoadActor("honeyright")..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;CenterY;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.2);
	};
}