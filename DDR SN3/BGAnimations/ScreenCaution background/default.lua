return Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/back"))..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
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
	};
	LoadActor("caution")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
}