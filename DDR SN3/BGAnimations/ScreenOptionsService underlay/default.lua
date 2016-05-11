return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-160;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-130;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-100;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-70;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-40;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-10;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y+20;zoomto,320,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT-120;y,SCREEN_CENTER_Y+50;zoomto,320,24;diffuse,color("#000000"));
	};
	LoadActor( "Back" )..{
		InitCommand=cmd(Center);
		OnCommand=cmd(addx,-SCREEN_WIDTH;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,0.5;addx,SCREEN_WIDTH);
	};
};