local t = Def.ActorFrame {};  

local instructionPage = "normal"

if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then instructionPage = "nonstop"
elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then instructionPage = "oni"
end

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_instructions",instructionPage))..{
        InitCommand=function(self) self:x(SCREEN_RIGHT+self:GetWidth()/2) self:y(SCREEN_CENTER_Y) end;
		OnCommand=function(self) self:accelerate(0.5):x(SCREEN_CENTER_X) end;
        OffCommand=function(self) self:accelerate(0.5):x(SCREEN_LEFT-self:GetWidth()/2):sleep(1) end;
	};
};

if IsStarterMode() then
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(s) s:Center() end,
		Def.Quad{
			InitCommand=function(s) s:diffuse(color "#000000"):zoomx(SCREEN_WIDTH):zoomy(64):diffusealpha(0) end,
			OnCommand=function(s) s:sleep(0.5):linear(0.2):diffusealpha(1):queuecommand("StarterBuild") end,
			StarterBuildCommand=function(s) AssembleStarter(); MESSAGEMAN:Broadcast("BuildDone") end,
			BuildDoneMessageCommand=function(s) s:linear(0.2):diffusealpha(0) end
		};
		Def.BitmapText{
			Text = "Please wait...",
			Font = "_handelgothic bt 20px",
			InitCommand=function(s) s:diffusealpha(0) end,
			OnCommand=function(s) s:sleep(0.5):linear(0.2):diffusealpha(1) end,
			BuildDoneMessageCommand=function(s) s:linear(0.2):diffusealpha(0) end
		}
	}
end
return t;