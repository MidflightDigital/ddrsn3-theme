local instructionPage = "normal"

if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then instructionPage = "nonstop"
elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then instructionPage = "oni"
end

return Def.ActorFrame{
	LoadActor(THEME:GetPathG("_instructions",instructionPage))..{
        InitCommand=function(self) self:x(SCREEN_RIGHT+self:GetWidth()/2) self:y(SCREEN_CENTER_Y) end;
		OnCommand=function(self) self:linear(0.4):x(SCREEN_CENTER_X) end;
        OffCommand=function(self) self:linear(0.4):x(SCREEN_LEFT-self:GetWidth()/2):sleep(0.01) end;
	};
};