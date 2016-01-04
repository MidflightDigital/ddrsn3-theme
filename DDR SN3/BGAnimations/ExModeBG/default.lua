local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor( "background" )..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;);
			OnCommand=function(self)
				if (not GAMESTATE:IsCourseMode()) then
					self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT);
				else
					self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT);
				end
			end;
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/2"))..{
			InitCommand=cmd(CenterY;x,SCREEN_LEFT;zoomx,SCREEN_WIDTH;rotationz,100;rotationx,100;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addx,SCREEN_WIDTH;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addx,-SCREEN_WIDTH;sleep,4;queuecommand,"On");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/2"))..{
			InitCommand=cmd(y,SCREEN_CENTER_Y-180;x,SCREEN_RIGHT;zoomx,SCREEN_WIDTH;rotationz,100;rotationx,100;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addx,-SCREEN_WIDTH;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;rotationx,100;rotationz,50;diffuse,color("#d40000");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(Center;rotationz,50;rotationx,100;diffuse,color("#d40000");diffusealpha,1;fadetop,0.5;fadebottom,0.5);
		};
	};
	Def.ActorFrame{
		LoadActor("circle")..{
			InitCommand=cmd(x,SCREEN_LEFT+80;y,SCREEN_CENTER_Y+20;zoom,0;diffusealpha,0.4);
			OnCommand=cmd(sleep,2;diffusealpha,0.4;zoom,0;linear,2;zoom,0.5;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,4.8;queuecommand,"On");
		};
		LoadActor("circle")..{
			InitCommand=cmd(x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y-40;zoom,0;diffusealpha,0.4);
			OnCommand=cmd(sleep,4;diffusealpha,0.4;zoom,0;linear,2;zoom,0.8;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,4.8;queuecommand,"On");
		};
		LoadActor("loc1")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-100;y,SCREEN_CENTER_Y+40;croptop,1;cropright,1);
			OnCommand=cmd(sleep,2;linear,0.5;croptop,0;sleep,0.2;linear,0.8;cropright,0;sleep,4;linear,0.8;cropright,0.8;sleep,0.1;linear,0.5;croptop,1;sleep,18;queuecommand,'On');
		};
		LoadActor("loc2")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y-20;croptop,1;cropleft,1);
			OnCommand=cmd(sleep,8;linear,0.5;croptop,0;sleep,0.2;linear,0.8;cropleft,0;sleep,4;linear,0.8;cropleft,0.8;sleep,0.1;linear,0.5;croptop,1;sleep,10;queuecommand,'On');
		};
		LoadActor("loc3")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-25;y,SCREEN_CENTER_Y-50;croptop,1;cropleft,1);
			OnCommand=cmd(sleep,18;linear,0.5;croptop,0;sleep,0.2;linear,0.8;cropleft,0;sleep,4;linear,0.8;cropleft,0.8;sleep,0.1;linear,0.5;croptop,1;sleep,18;queuecommand,'On');
		};
		LoadActor("ringsq")..{
			InitCommand=cmd(x,SCREEN_RIGHT-80;y,SCREEN_CENTER_Y-20;diffusealpha,0.4;rotationx,45;rotationy,45);
			OnCommand=cmd(spin;effectmagnitude,100,100,0);
		};
		LoadActor("ringsq")..{
			InitCommand=cmd(x,SCREEN_RIGHT-80;y,SCREEN_CENTER_Y-20;diffusealpha,0.4;rotationx,45;rotationy,-45);
			OnCommand=cmd(spin;effectmagnitude,100,100,0);
		};
	};
};

return t;