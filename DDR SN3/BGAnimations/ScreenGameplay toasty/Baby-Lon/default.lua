local t = Def.ActorFrame{};

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') and GAMESTATE:IsHumanPlayer('PlayerNumber_P1') == true and GAMESTATE:GetCurrentStyle():GetName() == "single" then
t[#t+1] = Def.ActorFrame {
	LoadActor("../toasty_maskP1 Single")..{
		InitCommand=cmd(diffusealpha,0;zwrite,1;blend,Blend.NoEffect;;clearzbuffer,true;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.8;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
	InitCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
	InitCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-1,0);
		end;
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.2;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180-40;y,SCREEN_BOTTOM+120;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180+40;y,SCREEN_CENTER_Y+40;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180+20;y,SCREEN_CENTER_Y+60;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180-20;y,SCREEN_CENTER_Y+40;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
};
elseif GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') and GAMESTATE:IsHumanPlayer('PlayerNumber_P2') == true and GAMESTATE:GetCurrentStyle():GetName() == "single" then
t[#t+1] = Def.ActorFrame {
	LoadActor("../toasty_maskP2 Single")..{
		InitCommand=cmd(diffusealpha,0;zwrite,1;clearzbuffer,true;blend,Blend.NoEffect;x,SCREEN_LEFT+180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
	InitCommand=cmd(diffusealpha,0;x,SCREEN_LEFT+180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_LEFT+180;y,SCREEN_CENTER_Y;);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-1,0);
		end;
		StartTransitioningCommand=cmd(ztest,true;diffusealpha,0;linear,0.166;diffusealpha,0.2;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_LEFT+180;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_LEFT+180-40;y,SCREEN_BOTTOM+120;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_LEFT+180+40;y,SCREEN_CENTER_Y+40;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_LEFT+180+20;y,SCREEN_CENTER_Y+60;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_LEFT+180-20;y,SCREEN_CENTER_Y+40;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_LEFT+180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
}
elseif GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') and GAMESTATE:IsHumanPlayer('PlayerNumber_P1') == true and GAMESTATE:GetCurrentStyle():GetName() == "versus" then
t[#t+1] = Def.ActorFrame {
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;Center);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;Center);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-1,0);
		end;
		StartTransitioningCommand=cmd(ztest,true;diffusealpha,0;linear,0.166;diffusealpha,0.2;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X-40;y,SCREEN_BOTTOM+120;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X+40;y,SCREEN_CENTER_Y+40;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y+60;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X-20;y,SCREEN_CENTER_Y+40;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;Center);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
}
elseif GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') and GAMESTATE:IsHumanPlayer('PlayerNumber_P2') == true and GAMESTATE:GetCurrentStyle():GetName() == "versus" then
t[#t+1] = Def.ActorFrame {
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;Center);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.6;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;Center);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-1,0);
		end;
		StartTransitioningCommand=cmd(ztest,true;diffusealpha,0;linear,0.166;diffusealpha,0.2;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X-40;y,SCREEN_BOTTOM+120;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X+40;y,SCREEN_CENTER_Y+40;zoomy,4);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y+60;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_CENTER_X-20;y,SCREEN_CENTER_Y+40;zoomx,1;zoomy,2);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;Center);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
}
end

return t