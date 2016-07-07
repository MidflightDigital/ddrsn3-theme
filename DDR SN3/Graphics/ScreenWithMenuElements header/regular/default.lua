local sleeptime = math.random(0.0,5.0);
local screenName = Var "LoadingScreen"

local t = Def.ActorFrame{
	LoadActor("under")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("top")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("grid")..{
		InitCommand=cmd(blend,Blend.Add;;diffuse,color("#044600");x,SCREEN_LEFT;halign,0);
		OnCommand=cmd(diffusealpha,0;queuecommand,"Animate");
		AnimateCommand=cmd(diffusealpha,1;sleep,sleeptime;decelerate,0.5;diffusealpha,0;sleep,sleeptime;accelerate,0.5;diffusealpha,1;queuecommand,"Animate");
		OffCommand=cmd(finishtweening);
	};
	LoadActor("glow")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
		OnCommand=cmd(cropright,1;sleep,1;queuecommand,"Animate";draworder,100);
		AnimateCommand=cmd(decelerate,0.1;cropleft,0;cropright,1;decelerate,0.8;cropright,0;sleep,sleeptime;decelerate,0.8;cropleft,1;sleep,sleeptime;queuecommand,"Animate");
		OffCommand=cmd(finishtweening);
	};
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
		SetCommand=function(self)
			if screenName == "ScreenSelectStyle" then
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/regular/1"))
			elseif screenName == "ScreenSelectPlayMode" then
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/regular/2"))
			elseif screenName == "ScreenSelectMusic" then
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/regular/3"))
			else
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/regular/tag"))
			end;
		end;
		OnCommand=cmd(queuecommand,"Set";addx,-SCREEN_WIDTH;sleep,0.4;decelerate,0.5;addx,SCREEN_WIDTH);
	};
};

return t;