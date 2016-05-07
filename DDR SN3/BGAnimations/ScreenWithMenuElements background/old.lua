local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor("honeyleft")..{
			InitCommand=cmd(halign,0;x,SCREEN_LEFT-50;rotationx,100;CenterY;diffusealpha,0.2;blend,Blend.Add;;);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/_bck"))..{
			InitCommand=cmd(FullScreen);
		};
--		LoadActor(THEME:GetPathB("","ScreenLogo background/stars"))..{
--			InitCommand=cmd(FullScreen;blend,Blend.Add;;diffusealpha,0.5);
--		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/1"))..{
			InitCommand=cmd(CenterY;x,SCREEN_LEFT;zoomx,SCREEN_WIDTH;rotationz,100;rotationx,100;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addx,SCREEN_WIDTH;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addx,-SCREEN_WIDTH;sleep,4;queuecommand,"On");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/1"))..{
			InitCommand=cmd(y,SCREEN_CENTER_Y-180;x,SCREEN_RIGHT;zoomx,SCREEN_WIDTH;rotationz,100;rotationx,100;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addx,-SCREEN_WIDTH;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;rotationx,100;rotationz,50;diffuse,color("#14fc00");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(Center;rotationz,50;rotationx,100;diffuse,color("#14fc00");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
	};
};

return t;