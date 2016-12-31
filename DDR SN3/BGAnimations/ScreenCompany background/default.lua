local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(diffusealpha,1);
	OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0);
	Def.Quad{
		InitCommand=cmd(Center;FullScreen);
	};
	LoadActor("konmai")..{
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X,SCREEN_CENTER_X+232);y,WideScale(SCREEN_CENTER_Y-120,SCREEN_CENTER_Y));
	};
	LoadActor("mf")..{
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X,SCREEN_CENTER_X-180);y,WideScale(SCREEN_CENTER_Y+127,SCREEN_CENTER_Y+7));
	};
};
t[#t+1] = Def.ActorFrame{
	LoadActor("caution")..{
		InitCommand=cmd(Center;diffusealpha,0);
		OnCommand=cmd(diffusealpha,0;sleep,7;linear,0.165;diffusealpha,1);
		OffCommand=cmd(sleep,10.365;linear,0.165;diffusealpha,0)
	};
};

return t;
