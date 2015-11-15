local counter = 0;
local t = Def.ActorFrame{
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
		self:diffusecolor(color("#14FE00"));
		self:zoomx(1.5);
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
		LoadActor(THEME:GetPathB("ScreenLogo","background/grid"))..{
			InitCommand=cmd(valign,1;Center;FullScreen;rotationx,120;zoom,0.6);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/grid"))..{
			InitCommand=cmd(valign,0;Center;FullScreen;rotationx,240;zoom,0.6);
		};
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:zoom(1);
	end;
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenLogo","background/ddrsn_logo.png"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9;);
		};
		Def.Quad{
			InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0.6"));
		};
		LoadActor("image")..{
			InitCommand=cmd(x,SCREEN_LEFT+182;y,SCREEN_CENTER_Y-50);
			OnCommand=cmd(addx,-274;accelerate,0.4;addx,274);
			TitleSelectionMessageCommand=function(self, params)
				local path = "/Themes/"..THEME:GetCurThemeName().."/Graphics/_ScreenTitleMenu image "..string.lower(params.Choice)..".png"
				if FILEMAN:DoesFileExist(path) then
					self:Load(path)
				end
			end;
			OffCommand=cmd(accelerate,0.4;addx,-274);
		};
		LoadActor("left_panel")..{
			InitCommand=cmd(x,SCREEN_LEFT+47;y,SCREEN_CENTER_Y);
			OnCommand=cmd(addx,-94;decelerate,0.2;addx,94);
		};
		LoadActor("home_dialog")..{
			InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-80);
			OnCommand=cmd(zoomy,0;sleep,0.1;accelerate,0.3;zoomy,1);
			OffCommand=cmd(zoomy,1;sleep,0.1;accelerate,0.3;zoomy,0);
		};
		Def.BitmapText{
			Font="_russell_square";
			Text="";
			InitCommand=function(self) self:hibernate(0.4):Center(X):y(SCREEN_BOTTOM-100):zoom(0.9):maxwidth(513):wrapwidthpixels(513):valign(0):vertspacing(8) end;
			TitleSelectionMessageCommand=function(self, params) self:settext(THEME:GetString("ScreenTitleMenu","Description"..params.Choice)) end;
			OnCommand=cmd(cropbottom,1;sleep,0.1;accelerate,0.3;cropbottom,0);
			OffCommand=cmd(cropbottom,0;sleep,0.1;accelerate,0.3;cropbottom,1);
		};
	};
};

return t;