local t = Def.ActorFrame{};

local xPosPlayer = {
    P1 = (SCREEN_RIGHT-180),
    P2 = (SCREEN_LEFT+180)
}

local yPosPlayer = {
    P1 = (SCREEN_CENTER_Y-120),
    P2 = (SCREEN_CENTER_Y+120)
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  local short = ToEnumShortString(pn)
  local env = GAMESTATE:Env()
  local char = {}
  char.Name = env["SNCharacter"..short] or ""
  char.Path = Characters.GetPath(char.Name)
if (char.Name ~= "") then
    char.Color = (Characters.GetConfig(char.Name)).color
--Player 1--
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			if GAMESTATE:GetCurrentStyle():GetName() == "single" then
				self:x(xPosPlayer[short]);
				self:y(SCREEN_CENTER_Y);
			elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
				self:x(SCREEN_CENTER_X);
				self:y(yPosPlayer[short]);
			end;
		end;
		ComboChangedMessageCommand=function(self, params)
		if params.Player ~= pn then return end
			local CurCombo = params.PlayerStageStats:GetCurrentCombo()
			if (CurCombo == 25) or (CurCombo ~= 0 and CurCombo % 50 == 0) then
				self:playcommandonchildren("Animate")
			end;
		end;
		LoadActor("../_Toasty/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;visible,false;diffuse,unpack(char.Color));
		AnimateCommand=cmd(visible,true;finishtweening;diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
		};
		LoadActor("../_Toasty/toasty_bg")..{
		InitCommand=cmd(setsize,200,SCREEN_HEIGHT;visible,false;blend,Blend.Add;diffuse,unpack(char.Color));
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
				if params.Player ~= pn then return end
			local CurCombo = params.PlayerStageStats:GetCurrentCombo()
				if CurCombo~= 0 and CurCombo % 100 == 0 then
					self:Load(char.Path .. "/combo100.png")
				elseif CurCombo == 25 then
					self:Load(char.Path .. "/combo.png")
				elseif CurCombo ~= 0 and CurCombo % 50 == 0 then
					self:Load(char.Path .. "/combo.png")
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
			InitCommand=function(s) s:visible(false):diffuse(unpack(char.Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(char.Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(char.Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_circles")..{
			InitCommand=function(s) s:visible(false):diffuse(unpack(char.Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
		};
		LoadActor("../_Toasty/toasty_gradient")..{
			InitCommand=function(s) s:setsize(200,SCREEN_HEIGHT):visible(false):diffuse(unpack(char.Color)) end,
			AnimateCommand=cmd(visible,true;blend,Blend.Add;finishtweening;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
		};
	};
end;
end;
return t;
