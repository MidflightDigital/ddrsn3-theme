local counter = 0;
local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
		self:diffusecolor(color("#14FE00"));
	end;
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/back.png"))..{
			InitCommand=cmd(Center;diffusealpha,0.8);
		};
		LoadActor(THEME:GetPathB("ScreenLogo","background/fog.png"))..{
			InitCommand=cmd(diffusealpha,0.5;Center;blend,Blend.Add;;fadetop,0.3;fadebottom,0.3);
		};
	};
	Def.ActorFrame{
		LoadActor("1")..{
			InitCommand=cmd(Center;zoomx,SCREEN_WIDTH);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,-300;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,300;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
		LoadActor("1")..{
			InitCommand=cmd(Center;zoomx,SCREEN_WIDTH);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,300;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-300;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/grid"))..{
			InitCommand=cmd(valign,1;Center;rotationx,120;zoom,0.7);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/grid"))..{
			InitCommand=cmd(valign,0;Center;rotationx,240;zoom,0.7);
		};
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:zoom(1);
	end;
	Def.ActorFrame{
		LoadActor("ddrsn_logoL")..{
			InitCommand=cmd(Center);
			OnCommand=cmd(diffusealpha,0;sleep,2;diffusealpha,0.4;zoom,1;linear,1.7;zoom,1.1;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,3.5;queuecommand,"On");
		};
		LoadActor("ddrsn_logo.png")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9);
		};
		LoadActor("ddrsn_logo.png")..{
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