return Def.ActorFrame{
	LoadActor("ddrsn_logobg")..{
		InitCommand=cmd(Center);
	};
	LoadActor("1")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;blend,add;linear,2;diffusealpha,0.55;addy,-300;effectperiod,4);
	};
	LoadActor("1")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;blend,add;linear,2;diffusealpha,0.55;addy,300;effectperiod,4);
	};