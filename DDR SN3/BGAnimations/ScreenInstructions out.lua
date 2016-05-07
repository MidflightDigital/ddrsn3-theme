return Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_ins out"))..{
		StartTransitioningCommand=cmd(play);
	};
};