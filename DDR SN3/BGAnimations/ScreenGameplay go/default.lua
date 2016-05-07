return Def.ActorFrame{
	LoadActor("go")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;zoomx,4;zoomy,0;accelerate,0.132;zoomx,1;zoomy,1;diffusealpha,1;sleep,1;accelerate,0.132;zoomx,4;zoomy,0;diffusealpha,0);
	};
};