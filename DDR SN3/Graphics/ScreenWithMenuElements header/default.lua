return Def.ActorFrame{
	LoadActor("base")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("time")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
	};
};