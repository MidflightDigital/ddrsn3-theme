local scrolltime = 95;

local t = Def.ActorFrame {
	InitCommand=cmd(Center);
	LoadActor("_space")..{
		InitCommand=cmd(y,-SCREEN_HEIGHT*1.5;fadebottom,0.125;fadetop,0.25);
		OnCommand=cmd(linear,scrolltime;addy,SCREEN_HEIGHT*1.5825);
	};
};

return t