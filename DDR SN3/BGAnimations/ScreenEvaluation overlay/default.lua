
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
	LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(halign,0;player,PLAYER_1;x,SCREEN_LEFT+110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180;zoomy,0;linear,0.2;zoomy,0);
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
	LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(halign,1;player,PLAYER_2;x,SCREEN_RIGHT-110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180;zoomy,0;linear,0.2;zoomy,0);
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
};

return t;