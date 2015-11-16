return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(diffusealpha,0;linear,0.3;diffusealpha,1);
	}
}