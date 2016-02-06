local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Information panel
	LoadActor("_info")..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT+11;y,SCREEN_CENTER_Y-75;);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(decelerate,0.264;addx,(SCREEN_WIDTH)+440);
	};
	-- Picture
	LoadActor("dancer"..masterPlayer)..{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-164;y,SCREEN_CENTER_Y+92;);
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:GetNumPlayersEnabled() > 1 then
				self:visible(false)
			end
		end;
	};
		--style
	LoadActor("style")..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+183);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0);
	};
};

return t;