return Def.ActorFrame {
	LoadActor( "Back" )..{
		InitCommand=cmd(Center);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,1;accelerate,0.5;addx,SCREEN_WIDTH);
	};
};
