return Def.ActorFrame{
	LoadActor("caution")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
}