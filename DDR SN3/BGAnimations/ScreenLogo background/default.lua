local counter = 0;
local t = Def.ActorFrame{
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;);
		LoadActor("back")..{
			InitCommand=cmd(diffuse,color("0,1,0,0.812"));
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/flash"))..{
			InitCommand=cmd(y,-50;x,-200;diffusealpha,0.5);
			OnCommand=cmd(spin;effectmagnitude,0,0,50);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/left flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,4;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/right flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,2;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;sleep,2;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/round grid"))..{
			InitCommand=cmd(diffusealpha,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor("shader");
	};
	Def.ActorFrame{
		LoadActor("ddrsn_logo")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+1;y,SCREEN_CENTER_Y-8;zoom,0.9);
		};
		LoadActor("ddrsn_logo")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9);
			OnCommand=cmd(sleep,2;diffusealpha,0.4;zoom,0.9;linear,2;zoom,1;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,3.5;queuecommand,"On");
		};
		LoadActor("ddrsn_konami")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-2;y,SCREEN_BOTTOM-40);
		};
	};
};

return t;
