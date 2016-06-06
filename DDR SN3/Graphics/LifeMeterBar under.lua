return Def.ActorFrame{
	InitCommand=cmd(diffusealpha,0.5);
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,1");zoomto,(SCREEN_WIDTH/2.53),13);
	};
	Def.Quad{
		InitCommand=cmd(diffuse,color("1,1,1,1");fadetop,0.8;fadebottom,0.4;zoomto,(SCREEN_WIDTH/2.53),13);
	};
};
