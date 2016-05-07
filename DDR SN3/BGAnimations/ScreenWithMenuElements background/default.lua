local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/back"))..{
			InitCommand=cmd(FullScreen);
		--My god you are amazing kenp.	
		OnCommand=function(self)
		local seed = math.random(1000)%13;
		--local seed = GAMESTATE:GetGameSeed()%13;
			if (seed == 12) then
				self:diffuse(color("1,1,0,0.812"));
				self:playcommand("AnimateA");
			elseif (seed == 11) then
				self:diffuse(color("1,0,0,0.812"));
				self:playcommand("AnimateB");
			elseif (seed == 10) then
				self:diffuse(color("1,0,1,0.812"));
				self:playcommand("AnimateC");
			elseif (seed == 9) then
				self:diffuse(color("0,0,1,0.812"));
				self:playcommand("AnimateD");
			elseif (seed == 8) then
				self:diffuse(color("0,1,1,0.812"));
				self:playcommand("AnimateE");
			elseif (seed == 7) then
				self:diffuse(color("0,1,0,0.812"));
				self:playcommand("AnimateF");
			elseif (seed == 6) then
				self:diffuse(color("1,0,1,0.812"));
				self:playcommand("AnimateG");
			elseif (seed == 5) then
				self:diffuse(color("1,0,0,0.812"));
				self:playcommand("AnimateH");
			elseif (seed == 4) then
				self:diffuse(color("1,1,0,0.812"));
				self:playcommand("AnimateI");
			elseif (seed == 3) then
				self:diffuse(color("0,1,0,0.812"));
				self:playcommand("AnimateJ");
			elseif (seed == 2) then
				self:diffuse(color("0,1,1,0.812"));
				self:playcommand("AnimateK");
			elseif (seed == 1) then
				self:diffuse(color("0,0,1,0.812"));
				self:playcommand("AnimateL");				
			else 
				self:rainbow();
				self:effectperiod(160);
				
			end;
		end;
		AnimateACommand=cmd(linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("1,1,0,0.812");queuecommand,"AnimateA");
		AnimateBCommand=cmd(linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("1,0,0,0.812");queuecommand,"AnimateB");
		AnimateCCommand=cmd(linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,0,1,0.812");queuecommand,"AnimateC");
		AnimateDCommand=cmd(linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("0,0,1,0.812");queuecommand,"AnimateD");
		AnimateECommand=cmd(linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("0,1,1,0.812");queuecommand,"AnimateE");
		AnimateFCommand=cmd(linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,1,0,0.812");queuecommand,"AnimateF");
		
		AnimateGCommand=cmd(linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("1,0,1,0.812");queuecommand,"AnimateG");
		AnimateHCommand=cmd(linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("1,0,0,0.812");queuecommand,"AnimateH");
		AnimateICommand=cmd(linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,1,0,0.812");queuecommand,"AnimateI");
		AnimateJCommand=cmd(linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("0,1,0,0.812");queuecommand,"AnimateJ");
		AnimateKCommand=cmd(linear,20;diffuse,color("0,0,1,0.812");linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("0,1,1,0.812");queuecommand,"AnimateK");
		AnimateLCommand=cmd(linear,20;diffuse,color("1,0,1,0.812");linear,20;diffuse,color("1,0,0,0.812");linear,20;diffuse,color("1,1,0,0.812");linear,20;diffuse,color("0,1,0,0.812");linear,20;diffuse,color("0,1,1,0.812");linear,20;diffuse,color("0,0,1,0.812");queuecommand,"AnimateL");
	
	};
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;diffusealpha,0.6);
		LoadActor(THEME:GetPathB("","ScreenLogo background/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*1,h*1);
				self:texcoordvelocity(-0.02,0);
			end;
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
		LoadActor(THEME:GetPathB("","ScreenLogo background/dots"))..{
			InitCommand=cmd(diffusealpha,0.05);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/round grid"))..{
			InitCommand=cmd(diffusealpha,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/shader"))
	};
	Def.ActorFrame{
		LoadActor("BoxBody") .. {
			InitCommand=cmd(zbuffer,true;z,-1000;Center;zoom,20;rotationy,75;rotationx,0;diffusealpha,0.5;spin;effectmagnitude,35,10,20;blend,'BlendMode_Add');
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(Center;zoom,1.5);
		LoadActor("inside dots back");
		LoadActor("ball");
		LoadActor("inside dots front");
		LoadActor("shine")..{
			InitCommand=cmd(diffuse,color("0.5,0.5,0.5,0.5"));
		};
		LoadActor("inside circle rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,5);
		};
		LoadActor("outer rim")..{
			InitCommand=cmd(spin;effectmagnitude,5,10,20);
		};
		LoadActor("middle rim")..{
			InitCommand=cmd(spin;effectmagnitude,-35,20,-50);
		};
		LoadActor("inner rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,30);
		};
	};
};

return t;