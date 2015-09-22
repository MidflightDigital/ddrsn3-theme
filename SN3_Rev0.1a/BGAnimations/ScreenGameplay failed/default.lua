local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {

    LoadActor("../failed.mp3") .. {
		StartTransitioningCommand=cmd(play);
	};

	LoadActor( "../door1" )..{
		OnCommand=cmd(zoomx,1.34;x,SCREEN_CENTER_X-214;y,SCREEN_CENTER_Y;addx,-288;sleep,0.000;sleep,0.316;linear,0.2;addx,320;sleep,1.167;sleep,3.383;linear,0.2;addx,-999);
	};

	LoadActor( "../door2" )..{
		OnCommand=cmd(zoomx,1.34;x,SCREEN_CENTER_X+214;y,SCREEN_CENTER_Y;addx,288;sleep,0.000;sleep,0.316;linear,0.2;addx,-320;sleep,1.167;sleep,3.383;linear,0.2;addx,999);
	};

	LoadActor("Failed") .. {
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;zoomy,0;zoomx,4;sleep,0.066;linear,0.132;diffusealpha,1;zoomy,1;zoomx,1;sleep,2.604;linear,0.132;zoomy,0;zoomx,4;diffusealpha,0);
	};

};

return t;