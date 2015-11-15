local t = LoadFallbackB()

t[#t+1] = LoadActor("select")..{ 
	InitCommand=cmd(x,SCREEN_RIGHT-240;y,SCREEN_BOTTOM-33.5;);
	OnCommand=cmd(draworder,199;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

return t