-- single
return Def.ActorFrame{
	LoadActor("_item")..{
		InitCommand=cmd(x,SCREEN_RIGHT-318;y,SCREEN_CENTER_Y+52;draworder,99);
		OnCommand=cmd(addx,758;sleep,0.264;decelerate,0.264;addx,-780;decelerate,0.1;addx,22);
		GainFocusCommand=cmd(glowshift;effectcolor1,color("1,1,1,0.2");effectcolor2,color("0,0,0,0");effectperiod,0.5);
		LoseFocusCommand=cmd(stopeffect);
		EnabledCommand=cmd(diffuse,color("1,1,1,1"));
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
		OffCommand=cmd(decelerate,0.05;addx,-22;decelerate,0.264;addx,780);
	};
	LoadActor("../_Style/_Style highlight")..{
		InitCommand=cmd(x,SCREEN_RIGHT-318;y,SCREEN_CENTER_Y+52;draworder,99);
		OnCommand=cmd(diffusealpha,0;sleep,0.264;sleep,0.528;diffusealpha,1);
		GainFocusCommand=cmd(visible,true;glowshift;blend,Blend.Add;;effectcolor1,color("#36ff00");effectcolor2,color("#114f00");effectperiod,0.2);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(visible,false);
	};
};
