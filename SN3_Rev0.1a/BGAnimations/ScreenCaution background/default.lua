return Def.ActorFrame {
	LoadActor( "../_black" )..{
		OnCommand=cmd();
	};

	LoadActor( "caution" )..{
		OnCommand=cmd(Center;FullScreen;diffusealpha,0;decelerate,0.3;diffusealpha,1;sleep,2.4;accelerate,0.3;diffusealpha,0);
	};
}