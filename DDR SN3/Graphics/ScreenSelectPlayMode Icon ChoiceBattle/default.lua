local t = Def.ActorFrame{};

if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
t[#t+1] = Def.ActorFrame {
	-- Information panel
	LoadActor("cpu")..{
		InitCommand=cmd(halign,0;x,SCREEN_CENTER_X-80;y,SCREEN_CENTER_Y-40);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
	LoadActor("tip")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+280;y,SCREEN_CENTER_Y+20);
		GainFocusCommand=cmd(zoomx,0;zoomy,0;visible,true;linear,0.05;zoomx,1;sleep,0.2;linear,0.1;zoomy,1;glowshift;effectcolor1,color("1,1,1,0.2");effectcolor2,color("0,0,0,0");effectperiod,1);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};
else
t[#t+1] = Def.ActorFrame {
	-- Information panel
	LoadActor("vs")..{
		InitCommand=cmd(halign,0;x,SCREEN_CENTER_X-80;y,SCREEN_CENTER_Y-40);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};
end
return t;