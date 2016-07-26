return Def.ActorFrame{
	LoadActor(THEME:GetPathS("","Common back"))..{
		StartTransitioningCommand=cmd(play);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;linear,0.3;diffusealpha,1;sleep,0.7);
	};
};
