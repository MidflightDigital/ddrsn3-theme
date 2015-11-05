return Def.ActorFrame{
	LoadActor("Door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.01);
		OnCommand=cmd(linear,0.792;x,(SCREEN_CENTER_X-50)-SCREEN_WIDTH);
	};
	LoadActor("Door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.01);
		OnCommand=cmd(linear,0.792;x,(SCREEN_CENTER_X+50)+SCREEN_WIDTH);
	};

}