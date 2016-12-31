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
		OnCommand=cmd(addy,-64;croptop,1;sleep,2.4;linear,0.233;addy,64;croptop,0;sleep,1.267;linear,0.233;addy,-64;croptop,1);
	};
	-- let the messages begin
	Def.ActorFrame {
		LoadActor("text_up")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+146;y,SCREEN_CENTER_Y+47);
			ShowCommand=cmd(zoomy,0;sleep,5.8;decelerate,0.3;zoomy,1;sleep,2;zoomy,0);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("text_jump")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+146;y,SCREEN_CENTER_Y+47);
			ShowCommand=cmd(zoomy,0;sleep,12.166;decelerate,0.3;zoomy,1;sleep,2;zoomy,0);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("bluehand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y+2);
			ShowCommand=cmd(rotationz,-90;addy,999;sleep,4;addy,-999;accelerate,0.266;addx,-80;sleep,0.8;addy,999);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("bluehand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+122;y,SCREEN_CENTER_Y+84);
			ShowCommand=cmd(rotationz,-90;addy,999;sleep,10.433;addy,-999;accelerate,0.266;addx,-80;sleep,0.8;addy,999);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("pinkhand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+240;y,SCREEN_CENTER_Y-34);
			ShowCommand=cmd(addy,999;sleep,5.5;addy,-999;linear,0.067;addy,-36;sleep,2.366;linear,0.167;addy,44;sleep,0;addy,999);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("bluehand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+246;y,SCREEN_CENTER_Y-34);
			ShowCommand=cmd(addy,999;sleep,11.933;addy,-999;linear,0.067;addy,-36;sleep,2.366;linear,0.167;addy,44;sleep,0;addy,999);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("bluehand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+108;y,SCREEN_CENTER_Y-34);
			ShowCommand=cmd(zoomx,-1;addy,999;sleep,11.933;addy,-999;linear,0.067;addy,-36;sleep,2.366;linear,0.167;addy,44;sleep,0;addy,999);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("greenhand")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+174;y,SCREEN_CENTER_Y-28);
			ShowCommand=cmd(diffusealpha,0;sleep,17.366;diffusealpha,1;linear,0.198;y,SCREEN_CENTER_Y-120;bob;effectperiod,0.5;effectmagnitude,0,15,0);
			OnCommand=cmd(queuecommand,"Show");
		};
		LoadActor("text_gameover")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+146;y,SCREEN_CENTER_Y+47);
			ShowCommand=cmd(zoomy,0;sleep,18.666;decelerate,0.3;zoomy,1);
			OnCommand=cmd(queuecommand,"Show");
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
