-- ScreenHowToPlay Overlay

local t = Def.ActorFrame{
	LoadActor("howtoplay big")..{
		Name="HowToPlayBig";
		InitCommand=cmd(Center);
		OnCommand=cmd(sleep,0.3;sleep,1.8;linear,0.2;addy,-50;croptop,1);
	};
	LoadActor("howtoplay small")..{
		Name="HowToPlaySmall";
		InitCommand=cmd(x,SCREEN_CENTER_X+130;y,SCREEN_TOP+25;);
		OnCommand=cmd(addy,-50;sleep,0.3;sleep,1.8;linear,0.2;addy,50);
	};
	LoadActor("feet")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,2.4;decelerate,0.3;addx,SCREEN_WIDTH;sleep,2;linear,0.3;zoomy,0);
	};
};

return t;