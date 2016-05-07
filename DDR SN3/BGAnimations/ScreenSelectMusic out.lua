return Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_swoosh"))..{
		StartTransitioningCommand=cmd(play);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffusealpha,0);
		OnCommand=cmd(sleep,0.65);
	};
};