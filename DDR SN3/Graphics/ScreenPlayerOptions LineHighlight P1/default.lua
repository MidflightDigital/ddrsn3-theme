local t = ...;
t = Def.ActorFrame{
	LoadActor("Colour.png")..{
	InitCommand=cmd(blend,Blend.Add;;diffusealpha,0.5);
	};
	Def.Sprite {
	Texture="ScreenPlayerOptions LineHighlight P1 1x2";
	
	Frame0000=0;
	Delay0000=0.5;
	
	Frame0001=1;
	Delay0001=0.5;
	InitCommand=cmd(addy,1;addx,-200);
	};	
};	
return t;