return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-160;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-130;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-100;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-70;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-40;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-10;zoomto,SCREEN_WIDTH-200,24;diffuse,color("#000000"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y+20;zoomto,SCREEN_WIDTH-500,24;diffuse,color("#000000"));
	};
	LoadActor( "Back" )..{
		InitCommand=cmd(Center);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,1;accelerate,0.5;addx,SCREEN_WIDTH);
	};
};
