local t = ...;
t = Def.ActorFrame{
	LoadActor("ScreenOptions line highlightPP1")..{
	InitCommand=cmd(diffuserightedge,color("1,1,1,0"));
	};
	LoadActor("ScreenOptions line highlightPB1")..{
		InitCommand=cmd(addx,-200);
	};
	Def.Sprite {
	Texture="ScreenPlayerOptions LineHighlight P1 1x2";
	
	Frame0000=0;
	Delay0000=0.5;
	
	Frame0001=1;
	Delay0001=0.5;
	InitCommand=cmd(addx,-200);
	};
	LoadActor("../Badges/P1")..{
		InitCommand=cmd(addx,-290;addy,0;zoomy,1.0;zoomx,1.0;);
	};
};	
return t;