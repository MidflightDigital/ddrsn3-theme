local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Information panel
	Def.Sprite {
	Texture="anim 4x2.png",
		InitCommand=function(self)
			self:draworder(100):x(66):y(77)
			self:SetAllStateDelays(0.0625)
		end,
		OnCommand=function(self)
			self:zoom(0):spin():effectmagnitude(0,0,-300):sleep(0.266):linear(0.15):zoom(1)
		end,
		OffCommand=function(self)
			self:bouncebegin(0.264):zoom(0)
		end
	};
	LoadActor("icon")..{
		GainFocusCommand=cmd(diffuse,color("1,1,1,1");zoom,1;linear,0.2;zoom,1.25);
		LoseFocusCommand=cmd(linear,0.2;zoom,1;diffuse,color("0.6,0.6,0.6,1"));
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
	};
	LoadActor("name")..{
		InitCommand=cmd(y,77);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
	};
};

return t;