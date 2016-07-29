local env = GAMESTATE:Env()
local charP2Name = env.SNCharacterP2 or ""
local charP2Path = Characters.GetPath(charP2Name)

local t = Def.ActorFrame{};

if (charP2Name ~= "") then
    local charP2Color = (Characters.GetConfig(charP2Name)).color
--Player 1--
if GAMESTATE:GetCurrentStyle():GetName() == "versus" then
  t[#t+1] = Def.ActorFrame{
    InitCommand=function(self)
      self:x(SCREEN_CENTER_X);
      self:y(SCREEN_CENTER_Y);
    end;
    LoadActor("toasty_maskP2 Versus")..{
      OnCommand=cmd(blend,Blend.NoEffect;zwrite,1;clearzbuffer,true;);
    };
  };
end;
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			if GAMESTATE:GetCurrentStyle():GetName() == "single" then
				self:x(SCREEN_LEFT+180);
				self:y(SCREEN_CENTER_Y);
			elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y+120);
			end;
      self:ztest(1);
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
		LoadActor("../_Toasty/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;visible,false;diffuse,unpack(charP2Color));
		AnimateCommand=cmd(visible,true;finishtweening;diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor("../_Toasty/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;visible,false;blend,Blend.Add;diffuse,unpack(charP2Color));
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*SCREEN_HEIGHT);
				self:texcoordvelocity(-0.5,0);
			end;
			AnimateCommand=cmd(visible,true;finishtweening;diffusealpha,0;linear,0.166;diffusealpha,0.4;sleep,1;linear,0.166;diffusealpha,0);
		};
		Def.Sprite{
			InitCommand=cmd(visible,false);
			ComboChangedMessageCommand=function(self, params)
				if params.Player ~= 'PlayerNumber_P2' then return end
			local CurCombo = params.PlayerStageStats:GetCurrentCombo()
				if CurCombo~= 0 and CurCombo % 100 == 0 then
					self:Load(charP2Path .. "/combo100.png"):queuecommand("Animate");
				elseif CurCombo == 25 then
					self:Load(charP2Path .. "/combo.png"):queuecommand("Animate");
				elseif CurCombo ~= 0 and CurCombo % 50 == 0 then
					self:Load(charP2Path .. "/combo.png"):queuecommand("Animate");
				elseif CurCombo == 0 then return
				end;
			end;
			AnimateCommand=function(self, params)
			self:visible(true):finishtweening():y(44):diffusealpha(0)
			:sleep(0.066):linear(0.1):addy(-4)
			:diffusealpha(1):linear(1):addy(-10)
			:linear(0.1):addy(-4)
			:diffusealpha(0):sleep(0.1):addy(18)
			end;
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(charP2Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(charP2Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(charP2Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(charP2Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_gradient")..{
			InitCommand=function(s) s:setsize(200,SCREEN_HEIGHT):visible(false):diffuse(unpack(charP2Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;;finishtweening;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
		};
	};
end;
return t;
