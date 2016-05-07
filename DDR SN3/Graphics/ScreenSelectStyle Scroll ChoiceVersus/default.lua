local t = Def.ActorFrame{
	-- Information panel
	LoadActor("_info")..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT+11;y,SCREEN_CENTER_Y-75;);
		GainFocusCommand=function(s) MESSAGEMAN:Broadcast("PadsTwo") s:visible(true):addx(-11):decelerate(0.1):addx(11) end;
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(decelerate,0.264;addx,(SCREEN_WIDTH)+440);
	};

	-- Picture
	LoadActor("../dancerP1")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+74;);
		OnCommand=function(self)
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):diffusealpha(1):decelerate(0.066):zoom(1):accelerate(0.066):zoom(0.8):decelerate(0.066):zoom(1);
			else
				self:visible(false);
			end;
		end;
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
	LoadActor("../dancerP2")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-110;y,SCREEN_CENTER_Y+115;);
		OnCommand=function(self)
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):diffusealpha(1):decelerate(0.066):zoom(1):accelerate(0.066):zoom(0.8):decelerate(0.066):zoom(1);
			else
				self:visible(false);
			end;
		end;
		GainFocusCommand=function(s) s:visible(true):bounceend(0.2):zoom(1) end;
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
	
--[[	LoadActor("dancerP1")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-197;y,SCREEN_CENTER_Y+88;);
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
	LoadActor("dancerP2")..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-87;y,SCREEN_CENTER_Y+128;);
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
--]]
		--style
	LoadActor("style")..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+183);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0);
	};
};

return t;