return Def.ActorFrame {
	InitCommand=cmd(sleep,40);
	LoadActor( "extreme_special_ending" )..{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-14;texturewrapping,1;zoomtowidth,610;zoomtoheight,420;diffusealpha,1;sleep,32;diffuse,0,0,0,1);
	};
	LoadActor( "glitchborder" )..{
		OnCommand=cmd(Center);
	};
	LoadActor( "logo" )..{
		OnCommand=cmd(diffusealpha,0;CenterX;y,SCREEN_CENTER_Y-14;zoomtowidth,610;zoomtoheight,420;linear,29.45;diffusealpha,0;linear,0.3;diffusealpha,1;sleep,3.5;diffusealpha,1;linear,0.8;diffusealpha,0);
	};
}