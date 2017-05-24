local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathS("","_swoosh"))..{
	OnCommand=cmd(play);
}

t[#t+1] = Def.ActorFrame{
	LoadFont("_handelgothic bt 40px")..{
		InitCommand=cmd(diffuse,color("#000000");xy,SCREEN_CENTER_X-300,SCREEN_CENTER_Y-120;diffusealpha,0;halign,0);
		OffCommand=cmd(decelerate,0.2;addx,100;diffusealpha,0);
		PlayStarterMessageCommand=function(s) s:settext("STARTER"):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayStandardMessageCommand=function(s) s:settext("STANDARD"):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayBattleMessageCommand=function(s) s:settext("BATTLE"):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayCourseMessageCommand=function(s) s:settext("COURSE"):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayEndlessMessageCommand=function(s) s:settext("ENDLESS"):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
	};
	LoadFont("_handelgothic bt 20px")..{
		InitCommand=cmd(diffuse,color("#000000");xy,SCREEN_CENTER_X-300,SCREEN_CENTER_Y-85;halign,0;valign,0;zoom,0.75);
		OffCommand=cmd(decelerate,0.2;zoomy,0);
		AnimCommand=cmd(stoptweening;zoomy,0;sleep,0.2;decelerate,0.4;zoomy,0.75);
		PlayStarterMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionStarter")):queuecommand("Anim") end,
		PlayStandardMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionStandard")):queuecommand("Anim") end,
		PlayBattleCPUMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleCPU")):queuecommand("Anim") end,
		PlayBattleVersusMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleVersus")):queuecommand("Anim") end,
		PlayCourseMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionCourse")):queuecommand("Anim") end,
		PlayEndlessMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionEndless")):queuecommand("Anim") end,
	};
};

--[[t[#t+1] = Def.Sprite{
	InitCommand=cmd(scaletoclipped,427,240;xy,SCREEN_LEFT+240,SCREEN_CENTER_Y-40);
	OnCommand=cmd(addx,-640;sleep,0.116;accelerate,0.25;addx,640);
	Anim1Command=cmd(linear,0.2;diffuse,color("0,0,0,1"));
	Anim2Command=cmd(linear,0.2;diffuse,color("1,1,1,1"));
	PlayStarterMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Starter")):queuecommand("Anim2") end,
	PlaySingleMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Standard")):queuecommand("Anim2") end,
	PlayBattleMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Battle")):queuecommand("Anim2") end,
	PlayCourseMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Course")):queuecommand("Anim2") end,
	PlayEndlessMessageCommand=function(s) s:queuecommand("Anim1"):Load(THEME:GetPathG("","_PlayMode/Endless")):queuecommand("Anim2") end,
	OffCommand=cmd(sleep,0.116;accelerate,0.25;addx,-640);
};]]--

return t
