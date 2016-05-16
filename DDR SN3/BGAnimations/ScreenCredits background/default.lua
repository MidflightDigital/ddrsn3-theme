local t = Def.ActorFrame {
	InitCommand=cmd(Center);
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,1"));
	};
};

return t