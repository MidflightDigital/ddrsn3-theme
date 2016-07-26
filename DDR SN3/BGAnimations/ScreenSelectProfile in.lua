return Def.ActorFrame{
	LoadActor( THEME:GetPathS("Profile","In") )..{
		OnCommand=cmd(queuecommand,("Play"));
		PlayCommand=cmd(play;);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,1;linear,0.1;diffusealpha,0);
	};
}
