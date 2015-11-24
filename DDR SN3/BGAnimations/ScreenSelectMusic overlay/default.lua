local t = Def.ActorFrame{
	LoadActor("SNDifficultyList.lua");
	LoadActor("bpmmeter.lua");
	LoadActor(THEME:GetPathG("","MusicWheelItem grades/default.lua"));
	LoadActor("labels")..{
		InitCommand=cmd(x,SCREEN_LEFT+201;y,SCREEN_CENTER_Y+7);
		OnCommand=cmd(draworder,2;diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
	Def.Sprite {
	Texture="WheelEffect 5x4",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y-16.5)
			self:SetAllStateDelays(0.04)
		end,
		OnCommand=function(self)
			self:addx(380):sleep(0.264):sleep(0.558):decelerate(0.231):addx(-380)
		end,
		OffCommand=function(self)
			self:accelerate(0.396):addx(380)
		end
	};
	LoadActor(THEME:GetPathG("","_footer/confirm2.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-42);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;addx,271;sleep,0.033;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/select1.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-42);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;addx,271;sleep,0.033;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/difficulty.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-150;y,SCREEN_BOTTOM-25);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;addx,271;sleep,0.033;sleep,0.05;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/select2.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-154;y,SCREEN_BOTTOM-42);
		OnCommand=cmd(diffuseblink;effectcolor1,1,1,1,1;effectcolor2,0,0,0,0;effectperiod,2;addx,271;sleep,0.033;decelerate,0.283;addx,-271;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
};

return t;
