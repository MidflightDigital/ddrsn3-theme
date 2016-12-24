local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathS("","_swoosh"))..{
	OnCommand=cmd(play);
}

t[#t+1] = Def.Sprite{
	InitCommand=cmd(scaletoclipped,427,240;xy,SCREEN_LEFT+240,SCREEN_CENTER_Y-40);
	OnCommand=cmd(addx,-640;sleep,0.116;accelerate,0.25;addx,640);
	Anim1Command=cmd(linear,0.2;diffuse,color("0,0,0,1"));
	Anim2Command=cmd(linear,0.2;diffuse,color("1,1,1,1"));
	PlayStarterMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Standard")):queuecommand("Anim2") end,
	PlaySingleMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Standard")):queuecommand("Anim2") end,
	PlayBattleMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Battle")):queuecommand("Anim2") end,
	PlayCourseMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Course")):queuecommand("Anim2") end,
	PlayEndlessMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Endless")):queuecommand("Anim2") end,
	OffCommand=cmd(sleep,0.116;accelerate,0.25;addx,-640);
};
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

return t
