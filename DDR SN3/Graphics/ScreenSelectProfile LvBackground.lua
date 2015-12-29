local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("ScreenSelectProfile LvBack02") .. {
		InitCommand=cmd(blend,Blend.Add;shadowlength,0;zoom,0;spin;effectmagnitude,0,0,180);
		OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.5;rotationz,180;linear,0.5;rotationz,1);
		OffCommand=cmd(linear,0.1;zoom,0.100;diffusealpha,0);
	};	
	
	
	LoadActor("ScreenSelectProfile LvBack01") .. {
		InitCommand=cmd(shadowlength,0;zoom,0);
		OnCommand=cmd(sleep,0.3;linear,0.1;zoom,0.5;);
		OffCommand=cmd(linear,0.1;zoom,0.100;diffusealpha,0);
	};

};


return t;