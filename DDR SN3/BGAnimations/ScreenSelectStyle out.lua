return Def.ActorFrame{
	LoadActor("_shared background")..{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(diffusealpha,0;sleep,0.65;diffusealpha,1;sleep,0.75);
	};
}