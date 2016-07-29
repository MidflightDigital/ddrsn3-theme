local t = Def.ActorFrame{
        Def.Quad{
                BeginCommand=function(self)
                        if IsSMOnlineLoggedIn('PlayerNumber_P1') then
                                self:visible(true):x(SCREEN_CENTER_X*1.5);
                        else
                                self:visible(false);
                        end;
                end;
                InitCommand=function(self)
                        self:setsize(280,SCREEN_HEIGHT):CenterY():diffuse(color("0,0,0,0.5"));
                end;
        };
};

--battleshit
if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
t[#t+1] = Def.ActorFrame{
	LoadActor("Battle Frame")..{
		InitCommand=cmd(CenterX;y,SCREEN_TOP+78);
	};
};
end;

t[#t+1] = Def.Quad {
  InitCommand=function(self)
      self:x(SCREEN_CENTER_X);
      self:y(SCREEN_CENTER_Y);
      self:diffuse(color("0,0,0,1"));
      self:setsize(200,480);
      self:diffusealpha(0);
  end;
ComboChangedMessageCommand=function(self, params)
  if params.Player ~= 'PlayerNumber_P1' then return end
    local CurCombo = params.PlayerStageStats:GetCurrentCombo()
    if CurCombo == 25 then
      self:queuecommand("Animate");
    elseif CurCombo ~= 0 and CurCombo % 50 == 0 then
      self:queuecommand("Animate");
    elseif CurCombo == 0 then return
    end;
end;
  AnimateCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
};

t[#t+1] = Def.Quad {
  InitCommand=function(self)
      self:x(SCREEN_CENTER_X);
      self:y(SCREEN_CENTER_Y);
      self:diffuse(color("0,0,0,1"));
      self:setsize(200,480);
      self:diffusealpha(0);
  end;
ComboChangedMessageCommand=function(self, params)
  if params.Player ~= 'PlayerNumber_P2' then return end
    local CurCombo = params.PlayerStageStats:GetCurrentCombo()
    if CurCombo == 25 then
      self:queuecommand("Animate");
    elseif CurCombo ~= 0 and CurCombo % 50 == 0 then
      self:queuecommand("Animate");
    elseif CurCombo == 0 then return
    end;
end;
  AnimateCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
};

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
t[#t+1] = Def.ActorFrame{
		LoadActor("P1 Toast.lua");
};

end;
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
t[#t+1] = Def.ActorFrame{
		LoadActor("P2 Toast.lua");
};
end;

return t;
