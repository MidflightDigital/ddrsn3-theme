return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
	LoadActor("warning")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0);
	};
	LoadActor("bemani")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;sleep,5.165;linear,0.165;diffusealpha,1);
		OffCommand=cmd(sleep,10.165;linear,0.165;diffusealpha,0);
	};
}