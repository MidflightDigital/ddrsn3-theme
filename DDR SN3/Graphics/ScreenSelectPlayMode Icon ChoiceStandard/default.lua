local t = Def.ActorFrame{
	-- Information panel
	LoadActor("info")..{
		InitCommand=cmd(halign,0;x,SCREEN_CENTER_X-80;y,SCREEN_CENTER_Y-40);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};

return t;