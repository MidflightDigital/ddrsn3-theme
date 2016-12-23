local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,1");Center);
		OnCommand=cmd(diffusealpha,0;queuecommand,"Anim");
		AnimCommand=cmd(sleep,3;linear,1;diffusealpha,0.75;sleep,0.4;linear,0.1;diffusealpha,0;sleep,2;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/ddrsn_logo"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		OnCommand=cmd(diffusealpha,1)
	};
	LoadActor(THEME:GetPathB("","_shared/logo flash"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		OnCommand=cmd(diffusealpha,0;queuecommand,"Anim");
		AnimCommand=cmd(sleep,4;sleep,0.4;linear,0.1;diffusealpha,1;linear,1;diffusealpha,0;sleep,1;queuecommand,"Anim");
	};
};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,1");setsize,SCREEN_WIDTH,25;CenterX;y,SCREEN_BOTTOM-80);
		OnCommand=cmd(cropright,1;decelerate,0.2;cropright,0);
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px",
		InitCommand=cmd(diffuse,color("#18ff00");xy,SCREEN_LEFT+180,SCREEN_BOTTOM-80;zoom,0.75;settext,"PRESS START BUTTON");
		OnCommand=cmd(cropleft,0;cropright,1;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		AnimCommand=cmd(cropleft,0;cropright,1;sleep,3.75;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		Anim2Command=cmd(diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;accelerate,0.2;cropleft,1;sleep,0.5;queuecommand,"Anim");
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px",
		InitCommand=cmd(diffuse,color("#ffffff");halign,1;xy,SCREEN_RIGHT-20,SCREEN_BOTTOM-80;zoom,0.75;settext,"THIS THEME SUPPORTS PROFILES!");
		OnCommand=cmd(cropleft,0;cropright,1;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		AnimCommand=cmd(cropleft,0;cropright,1;sleep,3.75;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		Anim2Command=cmd(sleep,3.75;accelerate,0.2;cropleft,1;queuecommand,"Anim");
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/sponsor"))..{
		InitCommand=cmd(halign,1;valign,0;x,SCREEN_RIGHT-10;y,SCREEN_TOP+10);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/ddrsn_konami"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/serial"))..{
		InitCommand=cmd(halign,0;valign,0;x,SCREEN_LEFT-10;y,SCREEN_TOP+5);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Free" then
				self:visible(true)
				self:Center()
			else
				self:visible(false)
			end;
		end;
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Free" then
				self:visible(true)
				self:Center()
			else
				self:visible(false)
			end;
		end;
		OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,1;glowshift;effectperiod,0.6);
	};
};



return t;
