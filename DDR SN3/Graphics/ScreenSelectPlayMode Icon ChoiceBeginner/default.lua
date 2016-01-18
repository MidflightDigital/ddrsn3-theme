local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Information panel
	Def.Sprite {
	Texture="anim 4x2.png",
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-254+44):y(SCREEN_CENTER_Y-53)
			self:SetAllStateDelays(0.0625)
		end,
		OnCommand=function(self)
			self:spin():effectmagnitude(0,0,-300):zoomx(1):zoomy(0):linear(0.033):zoomx(1.354):zoomy(0.01):linear(0.066):zoomx(1.397):zoomy(1.071):sleep(0.033):linear(0.033):zoomx(1):zoomy(1.142):linear(0.033):zoomy(1.285):linear(0.033):zoomy(1)
		end,
		LoseFocusCommand=function(self)
			self:sleep(0.116):zoomx(1.354):zoomy(0):linear(0.066):zoomx(1.397):zoomy(1.071):linear(0.033):zoomx(1):zoomy(1.142):linear(0.016):zoomy(1.285):linear(0.016):zoomy(1)
		end,
		GainFocusCommand=function(self)
			self:sleep(0.166):zoom(0)
		end,
		OffCommand=function(self)
			self:linear(0.116):addx(-100):diffusealpha(0):zoomy(0.5)
		end
	};
	LoadActor("nameunfocus.png")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-254;y,SCREEN_CENTER_Y-53);
		OnCommand=cmd(zoom,1;bob;effectperiod,1;effectmagnitude,0,2,0);
		LoseFocusCommand=cmd(sleep,0.116;zoomx,1.354;zoomy,0;linear,0.066;zoomx,1.397;zoomy,1.071;linear,0.033;zoomx,1;zoomy,1.142;linear,0.016;zoomy,1.285;linear,0.016;zoomy,1);
		GainFocusCommand=cmd(sleep,0.116;zoom,0);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
	};
	LoadActor("icon")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-196;y,SCREEN_CENTER_Y-104);
		OnCommand=cmd(zoomy,0);
		GainFocusCommand=cmd(zoomy,0;diffusealpha,0.5;sleep,0.114;sleep,0.033;zoomy,0.676;linear,0.033;zoomy,1;linear,0;diffusealpha,1);
		LoseFocusCommand=cmd(sleep,0.05;linear,0.066;zoomy,0;diffusealpha,0);
		OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	};
	LoadActor("info")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+4;y,SCREEN_CENTER_Y+89);
		OnCommand=cmd(draworder,5;zoom,0);
		GainFocusCommand=cmd(sleep,0.114;zoom,1);
		LoseFocusCommand=cmd(linear,0.066;addx,-7;linear,0;addx,26;sleep,0.016;linear,0;addx,-26;sleep,0.016;linear,0;addx,7;sleep,0.016;linear,0;zoom,0);
		OffCommand=cmd(linear,0.133;addx,-SCREEN_WIDTH);
	};
};

return t;