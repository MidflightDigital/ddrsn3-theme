return Def.ActorFrame{
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
	LoadActor(THEME:GetPathB("ScreenLogo","background/stars.png"))..{
		InitCommand=cmd(Center;zoom,2;blend,Blend.Add;;diffusealpha,0.5);
		OnCommand=cmd(spin;effectmagnitude,0,0,5);
	};
	--LoadActor(THEME:GetPathB("ScreenLogo","background/fog(stretch)"))..{
	--	InitCommand=cmd(CenterX;y,SCREEN_TOP;fadebottom,0.2;blend,Blend.Add;;diffusealpha,0.2;diffuse,color("#00ff00");zoomto,3700,650;customtexturerect,0,0,1,1);
	--	OnCommand=cmd(texcoordvelocity,0.01,0;);
	--};
	--LoadActor(THEME:GetPathB("ScreenLogo","background/grid.png"))..{
	--	InitCommand=cmd(Center;blend,Blend.Add;;diffuse,color("#00ff00");diffusealpha,0.5);
	--};
	LoadActor("circle")..{
			InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_TOP;zoom,0;diffusealpha,0.4);
			OnCommand=cmd(sleep,2;diffusealpha,0.4;zoom,0.9;linear,2;zoom,1;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,3.5;queuecommand,"On");
	};
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
		InitCommand=cmd(x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y+20;diffusealpha,0.4;rotationx,45;rotationy,45);
		OnCommand=cmd(spin;effectmagnitude,100,100,0);
	};
	LoadActor("ringsq")..{
		InitCommand=cmd(x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y+20;diffusealpha,0.4;rotationx,45;rotationy,-45);
		OnCommand=cmd(spin;effectmagnitude,100,100,0);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0);
	};
};