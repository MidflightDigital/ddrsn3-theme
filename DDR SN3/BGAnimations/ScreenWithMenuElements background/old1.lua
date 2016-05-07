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
	InitCommand=cmd(Center;queuecommand,"Animate";blend,Blend.Add;;diffusealpha,0.6);
	AnimateCommand=cmd(spin;effectmagnitude,0,0,10);
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
	InitCommand=cmd(Center;queuecommand,"Animate"zoom,2;blend,Blend.Add;;diffusealpha,0.6);
	AnimateCommand=cmd(spin;effectmagnitude,0,0,10);
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,-120;rotationx,75;zoomx,2;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,-60;linear,2;addx,60;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,-120;rotationx,75;zoomx,2;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,75;linear,2;addx,-75;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,120;rotationx,-75;zoomx,2;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,60;linear,2;addx,-60;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,120;rotationx,-75;zoomx,2;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;queuecommand,"Animate");
			AnimateCommand=cmd(linear,2;addx,-75;linear,2;addx,75;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,-120;rotationx,75;zoomx,2;diffusealpha,0.5;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/grid"))..{
			InitCommand=cmd(y,120;rotationx,-75;zoomx,2;diffusealpha,0.5;fadetop,0.5;fadebottom,0.5);
		};
	};
	Def.ActorFrame{
--[[	InitCommand=cmd(Center;queuecommand,"Animate";blend,Blend.Add;;diffusealpha,0.6);
	AnimateCommand=cmd(spin;effectmagnitude,-90,60,30);
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,1;zoom,0.2;rotationx,45);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,1;zoom,0.2;rotationx,90);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,1;zoom,0.2;rotationy,90);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,1;zoom,0.2;rotationy,45);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,0.2;zoom,0.5);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,0.2;zoom,0.5;rotationx,45);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,0.5;zoom,0.5;rotationx,90);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,0.5;zoom,0.5;rotationy,90);
		};
		LoadActor(THEME:GetPathB("","ScreenLogo background/tri"))..{
			InitCommand=cmd(diffusealpha,0.5;zoom,0.5;rotationy,45);
		};
	};
	--]]
		LoadActor("BoxBody") .. {
			InitCommand=cmd(zbuffer,true;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;z,-1000;zoom,10;rotationy,75;rotationx,0;diffusealpha,0.5;spin;effectmagnitude,35,10,20;blend,'BlendMode_Add');
		};
		LoadActor("BoxBody") .. {
			InitCommand=cmd(zbuffer,true;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;z,-1000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,20;rotationy,75;rotationx,0;diffuse,ColorLightTone(color("#FFFFFF"));spin;effectmagnitude,55,30,10;blend,'BlendMode_Add');
		};
		LoadActor("BoxBody") .. {
			InitCommand=cmd(zbuffer,true;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;z,-1000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,30;rotationy,75;rotationx,0;diffuse,ColorLightTone(color("#FFFFFF"));spin;effectmagnitude,18,75,75;blend,'BlendMode_Add');
		};
	};
};

return t;