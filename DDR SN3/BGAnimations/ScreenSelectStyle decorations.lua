local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{ 
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(addx,271;sleep,0.516000;sleep,0.033;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
	OffCommand=cmd(linear,0.4;addx,236;linear,0;diffusealpha,0);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{ 
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(addx,271;sleep,0.516000;sleep,0.033;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
	OffCommand=cmd(linear,0.4;addx,236;linear,0;diffusealpha,0);
}

return t