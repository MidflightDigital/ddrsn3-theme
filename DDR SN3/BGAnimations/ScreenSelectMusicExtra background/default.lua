local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/back"))..{
			InitCommand=cmd(FullScreen;diffuse,Color("Red"));
		};
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;diffusealpha,0.6);
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*1,h*1);
				self:texcoordvelocity(-0.02,0);
			end;
		};
		LoadActor(THEME:GetPathB("","_shared/flash"))..{
			InitCommand=cmd(y,-50;x,-200;diffusealpha,0.5);
			OnCommand=cmd(spin;effectmagnitude,0,0,50);
		};
		LoadActor(THEME:GetPathB("","_shared/left flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,4;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/right flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,2;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;sleep,2;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/round grid"))..{
			InitCommand=cmd(diffusealpha,0.5);
		};
		LoadActor(THEME:GetPathB("","_shared/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(Center;zoom,1.5;diffuse,color("1,1,1,1"));
		LoadActor("ball");
		LoadActor("shine")..{
			InitCommand=cmd(diffuse,color("0.5,0.5,0.5,0.5"));
		};
		LoadActor("inside circle rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,20);
		};
		LoadActor("outer rim")..{
			InitCommand=cmd(spin;effectmagnitude,20,40,80);
		};
		LoadActor("middle rim")..{
			InitCommand=cmd(spin;effectmagnitude,-140,80,-200);
		};
		LoadActor("inner rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,120);
		};
	};
};

return t;
