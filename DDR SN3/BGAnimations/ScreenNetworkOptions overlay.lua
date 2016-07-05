local t = Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:ReloadOverlayScreens()
	end
};

return t;
