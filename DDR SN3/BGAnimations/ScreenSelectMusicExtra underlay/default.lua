local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
  LoadActor("siren")..{
    InitCommand=cmd(CenterX;y,SCREEN_TOP-400;zoom,5;diffusealpha,0.5);
    OnCommand=cmd(spin;effectmagnitude,0,0,50);
  };
  Def.Quad{
    InitCommand=cmd(xy,SCREEN_RIGHT-166,SCREEN_CENTER_Y-20;setsize,300,SCREEN_HEIGHT;diffuse,color("0,0,0,1");skewx,1);
  };
};

t[#t+1] = Def.ActorFrame {
	LoadActor("../ScreenSelectMusic underlay/difficultylist")..{
		InitCommand=cmd(x,SCREEN_LEFT+163;y,SCREEN_CENTER_Y+141);
		OnCommand=cmd(draworder,1;cropright,1;sleep,0.264;sleep,0.6;linear,0.4;cropright,0);
		OffCommand=cmd(sleep,0.033;accelerate,0.363;x,-237);
	};
};

return t;
