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

--toasty loader
--[[if GAMESTATE:GetCurrentStyle():GetStyleType() ~= "StyleType_OnePlayerTwoSides" then
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
end;]]--

local style = GAMESTATE:GetCurrentStyle():GetStyleType()
local st = GAMESTATE:GetCurrentStyle():GetStepsType();
--toasty loader
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
t[#t+1] = Def.ActorFrame{
  LoadActor("P1Cutin.lua")..{
    OnCommand=cmd(setsize,200,SCREEN_HEIGHT);
    InitCommand=function(self)
      self:CenterY()
        if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
  				self:x(SCREEN_CENTER_X);
        elseif IsUsingCenter1Player then
          if st == "StepsType_Dance_Double" then
            if GetScreenAspectRatio() < 1.7 then
							self:visible(false);
						else
							self:x(SCREEN_CENTER_X-340);
						end;
          end;
        else
          self:x(SCREEN_RIGHT-180);
        end;
      end;
    };
};
end;
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
  t[#t+1] = Def.ActorFrame{
    LoadActor("P2Cutin.lua")..{
      OnCommand=cmd(setsize,200,SCREEN_HEIGHT);
      InitCommand=function(self)
        self:CenterY()
          if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
    				self:x(SCREEN_CENTER_X);
          elseif IsUsingCenter1Player then
            if st == "StepsType_Dance_Double" then
              if GetScreenAspectRatio() < 1.7 then
  							self:visible(false);
  						else
  							self:x(SCREEN_CENTER_X+340);
  						end;
            end;
          else
            self:x(SCREEN_LEFT+180);
          end;
        end;
      };
  };
end;

return t;
