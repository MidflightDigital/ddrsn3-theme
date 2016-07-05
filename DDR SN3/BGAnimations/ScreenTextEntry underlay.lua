return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;smooth,0.5;diffusealpha,0.75);
		OffCommand=cmd(smooth,0.5;diffusealpha,0);
	};
};