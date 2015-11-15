return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
	LoadActor("gameover")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1;sleep,0.198;sleep,1.65;linear,0.462;diffusealpha,0);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,1;linear,0.198;diffusealpha,0)
	};
};