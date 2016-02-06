local counter = 0;
local t = Def.ActorFrame{
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor("_bck")..{
			InitCommand=cmd(Center;FullScreen);
		};
		LoadActor("1")..{
			InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;rotationx,75;fadetop,0.5;fadebottom,0.5;diffuse,color("#14fc00"));
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor("1")..{
			InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;rotationx,-75;fadetop,0.5;fadebottom,0.5;diffuse,color("#14fc00"));
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,-SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor("grid")..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;zoomx,1.5;rotationx,75;diffusealpha,0.5;fadetop,0.5;fadebottom,0.5;diffuse,color("#14fc00"));
		};
		LoadActor("grid")..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+120;zoomx,1.5;rotationx,-75;diffusealpha,0.5;fadetop,0.5;fadebottom,0.5;diffuse,color("#14fc00"));
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