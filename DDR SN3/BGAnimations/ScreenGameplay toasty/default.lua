local charP1 = GAMESTATE:GetCharacter('PlayerNumber_P1'):GetDisplayName();
local charP2 = GAMESTATE:GetCharacter('PlayerNumber_P2'):GetDisplayName();

local t = Def.ActorFrame {
    ToastyAchievedMessageCommand=function(s, p)
        if SN3Debug then
            SCREENMAN:SystemMessage(string.format("Toasty! player: %s level: %s combo: %s",
                tostring(p.PlayerNumber),
                tostring(p.Level),
                tostring(p.ToastyCombo)))
        end
    end,
};

if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/ScreenGameplay toasty/" .. charP1 .. "/settings.txt") then
	if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') and GAMESTATE:IsHumanPlayer('PlayerNumber_P1') == true then
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			if GAMESTATE:GetCurrentStyle():GetName() == "single" then
				self:diffusealpha(0);
				self:x(SCREEN_RIGHT-180);
				self:y(SCREEN_CENTER_Y);
			elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
				self:diffusealpha(0);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
			end
		end;
		LoadActor(charP1.."/toasty_bg")..{
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor(charP1.."/toasty_bg")..{
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*0.5);
				self:texcoordvelocity(-1,0);
			end;
			StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.2;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor(charP1.."/toastyChar")..{
			StartTransitioningCommand=cmd(y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
		};
		LoadActor(charP1.."/toasty_circles")..{
			StartTransitioningCommand=cmd(blend,Blend.Add;;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor(charP1.."/toasty_circles")..{
			StartTransitioningCommand=cmd(blend,Blend.Add;;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor(charP1.."/toasty_circles")..{
			StartTransitioningCommand=cmd(blend,Blend.Add;;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor(charP1.."/toasty_circles")..{
			StartTransitioningCommand=cmd(blend,Blend.Add;;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor(charP1.."/toasty_gradient")..{
			StartTransitioningCommand=cmd(blend,Blend.Add;;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
		};
	};
	end;
elseif FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/ScreenGameplay toasty/" .. charP2 .. "/default.lua") and GAMESTATE:IsPlayerEnabled("PlayerNumber_P2") then
t[#t+1] = Def.ActorFrame {
	LoadActor(charP2);
};
end

return t
