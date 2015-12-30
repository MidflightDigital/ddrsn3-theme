local t = ...;
t = Def.ActorFrame{
	LoadActor("ScreenOptions line highlightPP1")..{
	InitCommand=cmd();
	};
	Def.Sprite {
	Texture="ScreenPlayerOptions LineHighlight P1 1x2";
	
	Frame0000=0;
	Delay0000=0.5;
	
	Frame0001=1;
	Delay0001=0.5;
	InitCommand=cmd(addx,-200);
	};
	LoadActor("P1Cursor")..{
		InitCommand=cmd(addx,-320;addy,0;zoomy,1.0;zoomx,1.0;bounce;effectmagnitude,-8,0,0;effectclock,'beatnooffset');
	};
};	
return t;