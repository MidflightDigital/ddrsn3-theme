
local t = Def.ActorFrame{
	LoadActor("1")..{
		InitCommand=cmd(x,SCREEN_LEFT+123;y,SCREEN_CENTER_Y+70);
		BeginCommand=cmd(playcommand,"Check1");
		OnCommand=cmd(draworder,9;addx,-250;sleep,0.2;linear,0.2;addx,250);
		OffCommand=cmd(linear,0.2;addx,-250);
		Check1Command=function(self,param)
			if GAMESTATE:IsPlayerEnabled(0) == false then
				self:visible(false)
			end
		end;
	};
	LoadActor("2")..{
		InitCommand=cmd(x,SCREEN_RIGHT-123;y,SCREEN_CENTER_Y+70);
		BeginCommand=cmd(playcommand,"Check2");
		OnCommand=cmd(draworder,9;addx,250;sleep,0.2;linear,0.2;addx,-250);
		OffCommand=cmd(linear,0.2;addx,250);
		Check2Command=function(self,param)
			if GAMESTATE:IsPlayerEnabled(1) == false then
				self:visible(false)
			end
		end;
	};
};

return t;