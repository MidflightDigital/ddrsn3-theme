local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathS("","_swoosh"))..{
	OnCommand=cmd(play);
}

local path = "_shared/SelMode/";

-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " 4_3",
	[math.floor(10000*16/9)] = " 16_9",
	[math.floor(10000*16/10)] = " 16_9"
}

--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(suffix,1,true) then
	aspect = suffix
else
	Warn("ScreenSelectPlayMode decorations: missing image \""..suffix.."\". Using fallback assets.")
	aspect = "4_3"
end

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand=cmd(scaletoclipped,369,207.5;halign,0;xy,SCREEN_LEFT+41,SCREEN_CENTER_Y-22);
		OnCommand=cmd(addx,-640;sleep,0.116;accelerate,0.25;addx,640);
		Anim1Command=cmd(linear,0.2;diffuse,color("0,0,0,1"));
		Anim2Command=cmd(linear,0.2;diffuse,color("1,1,1,1"));
		PlayStarterMessageCommand=function(s) s:finishtweening():queuecommand("Anim1"):Load(THEME:GetPathG("",path.."Images/"..aspect.."/Starter")):queuecommand("Anim2") end,
		PlayStandardMessageCommand=function(s) s:finishtweening():queuecommand("Anim1"):Load(THEME:GetPathG("",path.."Images/"..aspect.."/Standard")):queuecommand("Anim2") end,
		PlayBattleMessageCommand=function(s) s:finishtweening():queuecommand("Anim1"):Load(THEME:GetPathG("",path.."Images/"..aspect.."/Battle")):queuecommand("Anim2") end,
		PlayCourseMessageCommand=function(s) s:finishtweening():queuecommand("Anim1"):Load(THEME:GetPathG("",path.."Images/"..aspect.."/Course")):queuecommand("Anim2") end,
		PlayEndlessMessageCommand=function(s) s:finishtweening():queuecommand("Anim1"):Load(THEME:GetPathG("",path.."Images/"..aspect.."/Endless")):queuecommand("Anim2") end,
		OffCommand=cmd(sleep,0.116;accelerate,0.25;addx,-640);
	};
	Def.Sprite{
		InitCommand=cmd(xy,SCREEN_LEFT+38,SCREEN_CENTER_Y-154;diffusealpha,0;halign,0);
		OffCommand=cmd(decelerate,0.2;addx,100;diffusealpha,0);
		PlayStarterMessageCommand=function(s) s:Load(THEME:GetPathG("",path.."Titles/Starter")):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayStandardMessageCommand=function(s)s:Load(THEME:GetPathG("",path.."Titles/Standard")):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayBattleMessageCommand=function(s) s:Load(THEME:GetPathG("",path.."Titles/Battle")):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayCourseMessageCommand=function(s) s:Load(THEME:GetPathG("",path.."Titles/Course")):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
		PlayEndlessMessageCommand=function(s) s:Load(THEME:GetPathG("",path.."Titles/Endless")):finishtweening():diffusealpha(0):sleep(0.2):addx(100):decelerate(0.2):diffusealpha(1):addx(-105):smooth(0.1):addx(5) end,
	};
	LoadFont("_gotham Bold 18px")..{
		InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#004402");xy,SCREEN_LEFT+12,SCREEN_CENTER_Y+96;halign,0;valign,0;vertspacing,2);
		OffCommand=cmd(decelerate,0.2;zoomy,0);
		AnimCommand=cmd(stoptweening;zoomy,0;sleep,0.2;decelerate,0.4;zoomy,1);
		PlayStarterMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionStarter")):queuecommand("Anim") end,
		PlayStandardMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionStandard")):queuecommand("Anim") end,
		PlayBattleCPUMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleCPU")):queuecommand("Anim") end,
		PlayBattleVersusMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleVersus")):queuecommand("Anim") end,
		PlayCourseMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionCourse")):queuecommand("Anim") end,
		PlayEndlessMessageCommand=function(s) s:zoomy(0):settext(THEME:GetString("ScreenSelectPlayMode","DescriptionEndless")):queuecommand("Anim") end,
	};
};

return t
