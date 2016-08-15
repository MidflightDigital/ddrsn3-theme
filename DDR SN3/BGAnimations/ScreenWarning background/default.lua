local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center;blend,Blend.Add;;);
	LoadActor(THEME:GetPathB("","ScreenLogo background/bg"))..{
		OnCommand=cmd(diffusealpha,1;sleep,5;linear,0.165;diffusealpha,0);
	};
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,0.6"));
		OnCommand=cmd(diffusealpha,0.6;sleep,5;linear,0.165;diffusealpha,0);
	};
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center);
	LoadActor("werds")..{
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0)
	};
	LoadActor("bemani")..{
		OnCommand=cmd(diffusealpha,0;sleep,5.165;linear,0.165;diffusealpha,1);
		OffCommand=cmd(sleep,10.165;linear,0.165;diffusealpha,0);
	};
};

return t;
