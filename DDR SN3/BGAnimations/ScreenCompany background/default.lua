return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen);
	};
	LoadActor("bemani")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1;linear,0.165;diffusealpha,0);
		OffCommand=cmd(diffusealpha,0;sleep,24.9;linear,0.165;diffusealpha,1);
	};
}