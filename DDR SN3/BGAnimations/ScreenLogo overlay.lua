local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","ScreenLogo background/sponsor"))..{
		InitCommand=cmd(Center);
	};
	-- eamusement title --
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=cmd(Center);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/start"))..{
		InitCommand=cmd(Center);
		OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,1;glowshift;effectperiod,0.6);
	};
};

return t;