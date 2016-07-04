local env = GAMESTATE:Env()
local charP1Name = env.SNCharacterP1 or ""
local charP1Path = Characters.GetPath(charP1Name)
local charP2Name = env.SNCharacterP2 or ""
local charP2Path = Characters.GetPath(charP2Name)

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
if not SN3Debug then
if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') and charP1Path then
	local charP1Color = (Characters.GetConfig(charP1Name)).color
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			if GAMESTATE:GetCurrentStyle():GetName() == "single" then
				self:x(SCREEN_RIGHT-180);
				self:y(SCREEN_CENTER_Y);
			elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y-120);
				self:draworder(-1);
			end;
		end;
		LoadActor("grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;diffuse,unpack(charP1Color));
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor("grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;blend,Blend.Add;diffuse,unpack(charP1Color));
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*SCREEN_HEIGHT);
				self:texcoordvelocity(-0.5,0);
			end;
			StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.4;sleep,1;linear,0.166;diffusealpha,0);
		};
		Def.Sprite{
			StartTransitioningCommand=cmd(y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
			ComboChangedMessageCommand=function(self, params)
			if params.Player ~= 'PlayerNumber_P1' then return end
			local CurCombo = params.PlayerStageStats:GetCurrentCombo()
				if CurCombo > 75 then
					self:Load(charP1Path .. "/combo100.png");
				else
					self:Load(charP1Path .. "/combo.png");
				end;
			end;
		};
--[[		LoadActor(charP1 .. "/toastyChar")..{
			StartTransitioningCommand=cmd(y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
		};--]]
		LoadActor("grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("grayscaled/toasty_gradient")..{
			InitCommand=function(s) s:setsize(200,SCREEN_HEIGHT):diffuse(unpack(charP1Color)) end,
			StartTransitioningCommand=cmd(blend,Blend.Add;;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
		};
	};
end;
end;

if not SN3Debug then
if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') and charP2Path then
	local charP2Color = (Characters.GetConfig(charP2Name)).color
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			if GAMESTATE:GetCurrentStyle():GetName() == "single" then
				self:x(SCREEN_LEFT+180);
				self:y(SCREEN_CENTER_Y);
				self:draworder(99);
			elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y+120);
			end;
		end;
		LoadActor("grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;diffuse,unpack(charP2Color));
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor("grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;blend,Blend.Add;diffuse,unpack(charP2Color));
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*SCREEN_HEIGHT);
				self:texcoordvelocity(-0.5,0);
			end;
			StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.4;sleep,1;linear,0.166;diffusealpha,0);
		};
		Def.Sprite{
			StartTransitioningCommand=cmd(y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
            ComboChangedMessageCommand=function(self, params)
            if params.Player ~= 'PlayerNumber_P2' then return end
            local CurCombo = params.PlayerStageStats:GetCurrentCombo()
                if CurCombo > 75 then
                    self:Load(charP2Path .. "/combo100.png");
                else
                    self:Load(charP2Path .. "/combo.png");
                end;
            end;
		};
--[[		LoadActor(charP2 .. "/toastyChar")..{
			StartTransitioningCommand=cmd(y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
		};--]]
        LoadActor("grayscaled/toasty_circles")..{
            InitCommand=function(s) s:diffuse(unpack(charP2Color)) end,
            StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
        };
        LoadActor("grayscaled/toasty_circles")..{
            InitCommand=function(s) s:diffuse(unpack(charP2Color)) end,
            StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
        };
        LoadActor("grayscaled/toasty_circles")..{
            InitCommand=function(s) s:diffuse(unpack(charP2Color)) end,
            StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
        };
        LoadActor("grayscaled/toasty_circles")..{
            InitCommand=function(s) s:diffuse(unpack(charP2Color)) end,
            StartTransitioningCommand=cmd(blend,Blend.Add;;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
        };
        LoadActor("grayscaled/toasty_gradient")..{
            InitCommand=function(s) s:setsize(200,SCREEN_HEIGHT):diffuse(unpack(charP2Color)) end,
            StartTransitioningCommand=cmd(blend,Blend.Add;;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
        };
	};
end;
end;

return t
