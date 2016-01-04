return Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_ins in"))..{
		StartTransitioningCommand=cmd(play);
	};
};