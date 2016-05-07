return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(diffusealpha,1;linear,0.3;diffusealpha,0);
	}
}