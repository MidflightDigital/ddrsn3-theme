local env = GAMESTATE:Env()
local charP1Name = env.SNCharacterP1 or ""
local charP1Path = Characters.GetPath(charP1Name)
local charP2Name = env.SNCharacterP2 or ""
local charP2Path = Characters.GetPath(charP2Name)


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
--[[
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
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;diffuse,unpack(charP1Color));
		ComboChangedMessageCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;blend,Blend.Add;diffuse,unpack(charP1Color));
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*SCREEN_HEIGHT);
				self:texcoordvelocity(-0.5,0);
			end;
			ComboChangedMessageCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.4;sleep,1;linear,0.166;diffusealpha,0);
		};
		Def.Sprite{
			ComboChangedMessageCommand=function(self, params)
			if params.Player ~= 'PlayerNumber_P1' then return end
			local CurCombo = params.PlayerStageStats:GetCurrentCombo()
				if CurCombo > 75 then
					self:Load(charP1Path .. "/combo100.png");
				else
					self:Load(charP1Path .. "/combo.png");
				end;
			self:y(44):diffusealpha(0)
			:sleep(0.066):linear(0.1):addy(-4)
			:diffusealpha(1):linear(1):addy(-10)
			:linear(0.1):addy(-4)
			:diffusealpha(0):sleep(0.1):addy(18)
			:finishtweening()
			end;
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			ComboChangedMessageCommand=cmd(blend,Blend.Add;;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			ComboChangedMessageCommand=cmd(blend,Blend.Add;;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			ComboChangedMessageCommand=cmd(blend,Blend.Add;;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_circles")..{
			InitCommand=function(s) s:diffuse(unpack(charP1Color)) end,
			ComboChangedMessageCommand=cmd(blend,Blend.Add;;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("ScreenGameplay toasty/grayscaled/toasty_gradient")..{
			InitCommand=function(s) s:setsize(200,SCREEN_HEIGHT):diffuse(unpack(charP1Color)) end,
			ComboChangedMessageCommand=cmd(blend,Blend.Add;;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
		};
	};
end;
--]]
return t;
