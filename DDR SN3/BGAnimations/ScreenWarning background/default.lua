return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
	-- bgtile
	LoadActor(THEME:GetPathB("","ScreenLogo background/back"))..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/fog"))..{
		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.25;fadeleft,0.5;faderight,0.5;diffusecolor,color("#14FE00"));
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0,h*1);
			self:texcoordvelocity(0.2,0);
			self:diffusealpha(1);
			self:sleep(2);
			self:linear(0.165);
			self:diffusealpha(0);
		end;
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0);
	};
	LoadActor("warning")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1);
		OffCommand=cmd(sleep,5;linear,0.165;diffusealpha,0);
	};
	LoadActor("bemani")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;sleep,5.165;linear,0.165;diffusealpha,1);
		OffCommand=cmd(sleep,10.165;linear,0.165;diffusealpha,0);
	};
}