local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/sponsor"))..{
		InitCommand=cmd(halign,1;valign,0;x,SCREEN_RIGHT-10;y,SCREEN_TOP+10);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/serial"))..{
		InitCommand=cmd(halign,0;valign,0;x,SCREEN_LEFT-10;y,SCREEN_TOP+5);
	};
	-- eamusement title --
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
    InitCommand=cmd(Center;visible,false);
		SetCommand=function(self)
      if GAMESTATE:GetCoinMode() == 'CoinMode_Free' or GAMESTATE:EnoughCreditsToJoin() == true then
        self:visible(true)
      else
        self:visible(false)
      end
    end;
    OnCommand=cmd(queuecommand,"Set");
    CoinInsertedMessageCommand=cmd(queuecommand,"Set");
	};
  Def.Sprite{
    InitCommand=cmd(Center);
    BeginCommand=cmd(playcommand,"Set");
    SetCommand=function(self)
      -- check for free play, event mode
      local coinMode = GAMESTATE:GetCoinMode()
      if coinMode == 'CoinMode_Free' or GAMESTATE:EnoughCreditsToJoin() == true then
        self:visible(true)
        self:Load(THEME:GetPathB("","ScreenLogo background/start"));
        self:blend('BlendMode_Add'):diffusealpha(1):glowshift():effectperiod(0.6);
      else
        self:visible(false)
      end
    end;
    CoinInsertedMessageCommand=cmd(playcommand,"Set");
  };
};

return t;
