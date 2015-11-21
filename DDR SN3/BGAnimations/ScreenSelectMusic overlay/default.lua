local t = Def.ActorFrame{
	LoadActor("SNDifficultyList.lua")..{
		BeginCommand=cmd(playcommand,"IsCourseMode");
		IsCourseModeCommand=function(self,param)
			if GAMESTATE:IsCourseMode() == true then
				self:visible(false)
			end
		end;
	};
	LoadActor("bpmmeter.lua")..{
		BeginCommand=cmd(playcommand,"IsCourseMode");
		IsCourseModeCommand=function(self,param)
			if GAMESTATE:IsCourseMode() == true then
				self:visible(false)
			end
		end;
	};
	LoadActor("labels")..{
		BeginCommand=cmd(playcommand,"IsCourseMode");
		IsCourseModeCommand=function(self,param)
			if GAMESTATE:IsCourseMode() == true then
				self:visible(false)
			end
		end;
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
	Def.Sprite {
	Texture="help 1x3.png",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_RIGHT-200):y(SCREEN_BOTTOM-33.5)
			self:SetAllStateDelays(4)
		end,
		OnCommand=function(self)
			self:addy(54):sleep(0.2):decelerate(0.2):addy(-54)
		end,
		OffCommand=function(self)
			self:decelerate(0.2):addy(54)
		end
	};
};

return t;