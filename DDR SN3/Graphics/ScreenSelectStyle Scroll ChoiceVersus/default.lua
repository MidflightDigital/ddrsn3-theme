local t = Def.ActorFrame{
	-- Information panel
	LoadActor("_info")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+110;y,SCREEN_CENTER_Y-75;);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(decelerate,0.264;addx,(SCREEN_WIDTH)+440);
	};

	-- Picture
	LoadActor("dancerP1")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-187;y,SCREEN_CENTER_Y+88;);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
	LoadActor("dancerP2")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-87;y,SCREEN_CENTER_Y+128;);
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
		--style
	LoadActor("style")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-253;y,SCREEN_CENTER_Y+183);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0);
	};
};

return t;