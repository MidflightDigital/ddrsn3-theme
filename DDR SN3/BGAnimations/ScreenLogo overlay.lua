local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/sponsor"))..{
		InitCommand=cmd(halign,1;valign,0;x,SCREEN_RIGHT-10;y,SCREEN_TOP+10);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/serial"))..{
		InitCommand=cmd(halign,0;valign,0;x,SCREEN_LEFT-10;y,SCREEN_TOP+5);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Free" then
				self:visible(true)
				self:Center()
			else
				self:visible(false)
			end;
		end;
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Free" then
				self:visible(true)
				self:Center()
			else
				self:visible(false)
			end;
		end;
		OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,1;glowshift;effectperiod,0.6);
	};
};



return t;
