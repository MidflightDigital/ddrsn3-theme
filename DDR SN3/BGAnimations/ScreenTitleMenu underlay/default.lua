local counter = 0;
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenLogo","background/ddrsn_logobg.jpg"))..{
		InitCommand=cmd(Center;FullScreen);
	};
	LoadActor(THEME:GetPathB("ScreenLogo","background/ddrsn_logo.png"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9;diffusealpha,0.5;glowshift;effectcolor1,color("#14FE00");effectcolor2,color("0,0,0,0");effectperiod,2);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0.6"));
	};
	LoadActor("left_panel")..{
		InitCommand=cmd(x,SCREEN_LEFT+47;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-94;decelerate,0.2;addx,94);
	};
	LoadActor("image")..{
		InitCommand=cmd(x,SCREEN_LEFT+182;y,SCREEN_CENTER_Y-40);
		OnCommand=cmd(zoom,0.2;linear,0.4;zoom,1.3;linear,0.2;zoom,1);
	};
	Def.Quad{
		InitCommand=cmd(blend,Blend.Add;;x,SCREEN_LEFT+182;y,SCREEN_CENTER_Y-40);
		OnCommand=cmd(zoom,0.2;diffusealpha,0;linear,0.4;zoom,1.3;diffusealpha,1;linear,0.2;zoom,1;diffusealpha,0);
	};
	LoadActor("home_dialog")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-85);
		OnCommand=cmd(zoomy,0;sleep,0.1;accelerate,0.3;zoomy,1);
	};
};

return t;