local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor("back")..{
			InitCommand=cmd(FullScreen);
		};
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;queuecommand,"Animate");
	AnimateCommand=cmd(rotationz,0;linear,90;rotationz,360;queuecommand,"Animate");
		LoadActor(THEME:GetPathB("","ScreenLogo background/1"))..{
			InitCommand=cmd(y,-120;CenterX;zoomx,SCREEN_WIDTH;rotationx,75;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/1"))..{
			InitCommand=cmd(y,120;CenterX;zoomx,SCREEN_WIDTH;rotationx,-75;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,-SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;queuecommand,"Animate");
	AnimateCommand=cmd(rotationz,0;linear,90;rotationz,360;queuecommand,"Animate");
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,-120;rotationx,75;zoomx,1.5;diffuse,color("#14fc00");diffusealpha,0.7;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,-60;linear,2;addx,60;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,120;rotationx,-75;zoomx,1.5;diffuse,color("#14fc00");diffusealpha,0.7;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,60;linear,2;addx,-60;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,-120;rotationx,75;zoomx,1.5;diffuse,color("#14fc00");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,120;rotationx,-75;zoomx,1.5;diffuse,color("#14fc00");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
	};
};

return t;