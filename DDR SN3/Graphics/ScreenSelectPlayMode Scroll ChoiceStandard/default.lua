local t = Def.ActorFrame{
	-- Information panel
	LoadActor("../_inner")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,0.9;spin;effectmagnitude,0,0,40);
		GainFocusCommand=cmd(visible,true;zoom,0.5;linear,0.2;zoom,0.9);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("../_outer")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,0.9;spin;effectmagnitude,0,0,-40);
		GainFocusCommand=cmd(visible,true;zoom,0.5;linear,0.2;zoom,0.9);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("../_outer")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1;spin;effectmagnitude,0,0,40);
		GainFocusCommand=cmd(visible,true;zoom,0.5;linear,0.2;zoom,1);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("../_outer")..{
		OnCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1;spin;effectmagnitude,0,0,-40);
		GainFocusCommand=cmd(visible,true;zoom,0.5;linear,0.2;zoom,1);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("icon")..{
		OnCommand=cmd(diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1"));
		GainFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("1,1,1,1");zoom,1);
		LoseFocusCommand=cmd(zoom,0.9;diffuse,color("0,0,0,1");linear,0.2;diffuse,color("0.5,0.5,0.5,1");zoom,1);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
};

return t;