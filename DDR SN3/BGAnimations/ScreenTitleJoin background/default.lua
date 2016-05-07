-- This is home mode looking stuff.
setenv("GalleryPage",nil)
setenv("InfoIndex",nil)

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenLogo","background"));
	Def.Quad{
		--InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,0.625"));
	};
};

return t;