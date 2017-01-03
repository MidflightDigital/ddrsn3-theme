local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
  LoadActor("siren")..{
    InitCommand=cmd(CenterX;y,SCREEN_TOP-400;zoom,5;diffusealpha,0.5);
    OnCommand=cmd(spin;effectmagnitude,0,0,50);
  };
  Def.Quad{
    InitCommand=cmd(xy,SCREEN_RIGHT-166,SCREEN_CENTER_Y-20;setsize,300,SCREEN_HEIGHT;diffuse,color("0,0,0,0.9");skewx,1);
  };
};

return t;
