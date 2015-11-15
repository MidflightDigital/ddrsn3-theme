return Def.ActorFrame{
	LoadActor("Door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y;zoom,1.01;halign,1);
		OnCommand=cmd(linear,0.792;x,SCREEN_CENTER_X-SCREEN_WIDTH);
	};
	LoadActor("Door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-50;y,SCREEN_CENTER_Y;zoom,1.01;halign,0);
		OnCommand=cmd(linear,0.792;x,SCREEN_CENTER_X+SCREEN_WIDTH);
	};

}