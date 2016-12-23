local t = Def.ActorFrame{};

--[[t[#t+1] = Def.ActorFrame{
	--top shade
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,1");Center);
		OnCommand=cmd(sleep,13;linear,0.2;diffusealpha,0;queuecommand,"Anim");
		AnimCommand=cmd(sleep,3;linear,1;diffusealpha,0.75;sleep,0.2;linear,0.1;diffusealpha,0;sleep,2;queuecommand,"Anim");
	};
	--white effect
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;Center;);
		OnCommand=cmd(cropleft,0.5;cropright,0.5;croptop,0.5;cropbottom,0.5;sleep,0.2;linear,0.1;cropleft,0;cropright,0;croptop,0.4;cropbottom,0.4;linear,0.1;croptop,0.5;cropbottom,0.5;linear,4;croptop,0;cropbottom,0
		;sleep,6.2;sleep,2.5;linear,0.1;diffusealpha,0);
	};
};
t[#t+1] = Def.ActorFrame{
	--Shades
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,1");setsize,SCREEN_WIDTH,SCREEN_HEIGHT/2;CenterX;valign,1;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addy,-40;sleep,0.7;linear,8;addy,-SCREEN_WIDTH);
	};
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,1");setsize,SCREEN_WIDTH,SCREEN_HEIGHT/2;CenterX;valign,0;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addy,40;sleep,0.7;linear,8;addy,SCREEN_WIDTH);
	};
	LoadActor(THEME:GetPathB("","_shared/arrow"))..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y-40;diffuse,color("1,1,0,1"));
		OnCommand=cmd(rotationz,180;addy,-SCREEN_HEIGHT;sleep,0.2;linear,0.4;addy,SCREEN_HEIGHT;linear,0.1;rotationz,0;linear,8;addy,-SCREEN_HEIGHT);
	};
	LoadActor(THEME:GetPathB("","_shared/arrow"))..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y+40;diffuse,color("1,1,0,1"));
		OnCommand=cmd(rotationz,0;addy,SCREEN_HEIGHT;sleep,0.2;linear,0.4;addy,-SCREEN_HEIGHT;linear,0.1;rotationz,180;linear,8;addy,SCREEN_HEIGHT);
	};
};]]--
t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;Center;);
		OnCommand=cmd(sleep,4;linear,0.1;diffusealpha,0);
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px",
		InitCommand=cmd(settext,"Welcome to DDR SuperNOVA3";diffusealpha,0;Center;zoom,0.75;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;sleep,2;linear,1;diffusealpha,1;sleep,1;diffusealpha,0);
	};
	--Left Square
	Def.Quad{
		InitCommand=cmd(setsize,15,15;xy,SCREEN_CENTER_X-140,SCREEN_CENTER_Y;diffuse,color("0,0,0,1"));
		OnCommand=cmd(zoom,0;sleep,2;linear,1;diffusealpha,0.75;zoom,1;rotationz,405;linear,1;addx,-20;sleep,0.25;diffusealpha,0);
	};
	--Right Square
	Def.Quad{
		InitCommand=cmd(setsize,15,15;xy,SCREEN_CENTER_X+140,SCREEN_CENTER_Y;diffuse,color("0,0,0,1"));
		OnCommand=cmd(zoom,0;sleep,2;linear,1;diffusealpha,0.75;zoom,1;rotationz,405;linear,1;addx,20;sleep,0.25;diffusealpha,0);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/ddrsn_logo"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		OnCommand=cmd(diffusealpha,0;sleep,4;diffusealpha,1)
	};
	LoadActor(THEME:GetPathB("","_shared/logo flash"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		OnCommand=cmd(diffusealpha,0;sleep,4;linear,0.1;diffusealpha,1;sleep,0.1;linear,0.1;diffusealpha,0;queuecommand,"Anim");
		AnimCommand=cmd(sleep,4.2;linear,0.1;diffusealpha,1;linear,1;diffusealpha,0;sleep,1;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/logo flash"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		OnCommand=cmd(diffusealpha,0;sleep,4;linear,0.1;diffusealpha,1;sleep,0.1;linear,0.1;diffusealpha,0;queuecommand,"Anim");
		AnimCommand=cmd(cropright,0;cropleft,1;fadeleft,0.2;faderight,0.2;diffusealpha,0.5;sleep,6;linear,0.2;cropleft,0;linear,0.2;cropright,1;queuecommand,"Wait");
		WaitCommand=cmd(sleep,2;queuecommand,"Anim");
	};
};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,1");setsize,SCREEN_WIDTH,25;CenterX;y,SCREEN_BOTTOM-80);
		OnCommand=cmd(cropright,1;sleep,4;decelerate,0.2;cropright,0);
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px",
		InitCommand=cmd(diffuse,color("#18ff00");xy,SCREEN_LEFT+180,SCREEN_BOTTOM-80;zoom,0.75;settext,"PRESS START BUTTON");
		OnCommand=cmd(cropleft,0;cropright,1;sleep,4;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		AnimCommand=cmd(cropleft,0;cropright,1;sleep,3.75;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		Anim2Command=cmd(diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;linear,0.1;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.5;accelerate,0.2;cropleft,1;sleep,0.5;queuecommand,"Anim");
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px",
		InitCommand=cmd(diffuse,color("#ffffff");halign,1;xy,SCREEN_RIGHT-20,SCREEN_BOTTOM-80;zoom,0.75;settext,"THIS THEME SUPPORTS PROFILES!");
		OnCommand=cmd(cropleft,0;cropright,1;sleep,4;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		AnimCommand=cmd(cropleft,0;cropright,1;sleep,3.75;decelerate,0.2;cropright,0;queuecommand,"Anim2");
		Anim2Command=cmd(sleep,3.75;accelerate,0.2;cropleft,1;queuecommand,"Anim");
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/sponsor"))..{
		InitCommand=cmd(halign,1;valign,0;x,SCREEN_RIGHT-10;y,SCREEN_TOP+10);
		OnCommand=cmd(cropbottom,1;sleep,4;linear,0.2;cropbottom,0);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/ddrsn_konami"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40);
		OnCommand=cmd(diffusealpha,0;sleep,4;diffusealpha,1);
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
