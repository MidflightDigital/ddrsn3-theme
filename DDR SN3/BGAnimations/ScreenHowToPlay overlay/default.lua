-- ScreenHowToPlay Overlay

-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " 4_3",
	[math.floor(10000*16/9)] = " 16_9",
	[math.floor(10000*16/10)] = " 16_9"
}
--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

local lifeFrame = "normal"

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(THEME:GetPathG("ScreenGameplay","LifeFrame/"..lifeFrame..suffix),1,true) then
	lifeFrame = lifeFrame .. suffix
	line = "lines" .. suffix
else
	Warn("ScreenGameplay LifeFrame: missing frame \""..lifeFrame..suffix.."\". Using fallback assets.")
	lifeFrame = lifeFrame.." 4_3"
	line = "lines 4_3"
end

local t = Def.ActorFrame{
	LoadActor("howtoplay big")..{
		Name="HowToPlayBig";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(sleep,0.3;sleep,1.8;linear,0.2;addy,-50;croptop,1);
	};
	LoadActor("howtoplay small")..{
		Name="HowToPlaySmall";
		InitCommand=cmd(x,SCREEN_CENTER_X+130;y,SCREEN_TOP+25;);
		OnCommand=cmd(addy,-50;sleep,0.3;sleep,1.8;linear,0.2;addy,50);
	};
	LoadActor("feet")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,2.4;decelerate,0.3;addx,SCREEN_WIDTH;sleep,2;linear,0.3;zoomy,0);
	};
	--Pre-Step message
	Def.ActorFrame {
		LoadActor("taphand")..{
			InitCommand=cmd(;rotationz,270;x,SCREEN_LEFT+400;y,SCREEN_CENTER_Y-130);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,-20,0,0;diffusealpha,0;sleep,6;linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
		};
		LoadActor("tapmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,6;linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
		};
	};
-- 1st Step -- DOWN
	Def.ActorFrame {
		LoadActor("taphand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-128;y,SCREEN_CENTER_Y-60);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,0,20,0;diffusealpha,0;sleep,9.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
		LoadActor("tapmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,9.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
	};
--2nd Step -- UP
	Def.ActorFrame {
		LoadActor("taphand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+192;y,SCREEN_CENTER_Y-60);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,0,20,0;diffusealpha,0;sleep,12.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
		LoadActor("tapmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,12.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
	};
--3rd Step -- LEFT
	Def.ActorFrame {
		LoadActor("taphand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+64;y,SCREEN_CENTER_Y-60);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,0,20,0;diffusealpha,0;sleep,15.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
		LoadActor("tapmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,15.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
	};
--4th Step -- JUMP
	Def.ActorFrame {
		LoadActor("jumphands")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y-60);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,0,20,0;diffusealpha,0;sleep,18.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
		LoadActor("jumpmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,18.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
	};
--Misstep
	Def.ActorFrame {
		LoadActor("taphand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+228;y,SCREEN_CENTER_Y-130);
			OnCommand=cmd(bob;effectperiod,1;effectmagnitude,0,20,0;diffusealpha,0;sleep,22.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
		LoadActor("missmessage")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+40);
			OnCommand=cmd(diffusealpha,0;sleep,22.7;linear,0;diffusealpha,1;sleep,1.7;linear,0;diffusealpha,0);
		};
	};
};
t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..lifeFrame))..{
		InitCommand=function(self)
			self:x(WideScale(SCREEN_CENTER_X-172,SCREEN_CENTER_X-237)):y(SCREEN_TOP+25)
		end,
	};
t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..line))..{
	InitCommand=function(self)
		self:x(WideScale(SCREEN_CENTER_X-172,SCREEN_CENTER_X-237)):y(SCREEN_TOP+25)
		:diffusealpha(0.4)
	end,
};

t[#t+1] = LoadActor(THEME:GetPathG("","Badges/P1"))..{
	InitCommand=function(self)
		self:x(SCREEN_LEFT+10):y(SCREEN_TOP+25)
	end;
};

return t;
