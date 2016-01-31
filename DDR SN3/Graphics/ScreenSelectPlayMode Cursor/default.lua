local t = Def.ActorFrame{
	-- Information panel
	LoadActor("inner")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1;spin;effectmagnitude,0,0,120);
		GainFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1);
		LoseFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("0.5,0.5,0.5,1");zoom,1);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("outer")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1;spin;effectmagnitude,0,0,-120);
		GainFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1);
		LoseFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("0.5,0.5,0.5,1");zoom,1);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
};

return t;