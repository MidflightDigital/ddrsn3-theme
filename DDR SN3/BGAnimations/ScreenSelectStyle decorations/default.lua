local t = LoadFallbackB()


t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
};
t[#t+1] = Def.Sprite{
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT+11;y,SCREEN_CENTER_Y-75);
	OnCommand=function(s) s:addx(379):sleep(0.264):decelerate(0.264):addx(-379):decelerate(0.1):addx(11) end;
	Anim1Command=function(s) s:addx(-11) end,
	Anim2Command=function(s) s:decelerate(0.1):addx(11) end,
	PadsOneMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceSingle/_info")):queuecommand("Anim2") end;
	PadsTwoMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceVersus/_info")):queuecommand("Anim2") end;
	PadsDoubleMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceDouble/_info")):queuecommand("Anim2") end;
	OffCommand=cmd(decelerate,0.264;addx,(SCREEN_WIDTH)+440);
};

return t
