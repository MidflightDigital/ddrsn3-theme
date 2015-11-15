local t = Def.ActorFrame{
	LoadActor("left_panel")..{
		InitCommand=cmd(x,SCREEN_LEFT+47;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-94;decelerate,0.2;addx,94);
		OffCommand=cmd(decelerate,0.2;addx,-94);
	};
	Def.Quad{
		InitCommand=cmd(x,SCREEN_LEFT+120;CenterY;diffuse,color("#02ff00");zoomto,5,SCREEN_HEIGHT);
		OnCommand=cmd(croptop,0.8;cropbottom,0.8;sleep,0.2;accelerate,0.5;croptop,0;cropbottom,0.2);
		OffCommand=cmd(accelerate,0.2;croptop,1;cropbottom,1);
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT+120;y,SCREEN_BOTTOM-120;diffuse,color("#02ff00");zoomto,SCREEN_WIDTH,5);
		OnCommand=cmd(cropright,1;sleep,0.4;accelerate,0.5;cropright,0);
		OffCommand=cmd(accelerate,0.2;cropright,1);
	};
};

return t;