local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{ 
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;hibernate,2;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{ 
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;hibernate,2;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

return t