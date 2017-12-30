local t = Def.ActorFrame{
  LoadActor("p1_left")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("../side_light")..{
    InitCommand=cmd(x,-22);
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffuseshift;blend,Blend.Add;effectcolor1,color("1,1,1,0.5");effectcolor2,color("0,0,0,0");effectclock,'beatnooffset');
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("p1_cursor")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };

  LoadActor("../circle_light")..{
    InitCommand=cmd(xy,-8.5,-1;blend,Blend.Add;diffuse,PlayerColor(PLAYER_1));
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffusealpha,0.5;spin;effectmagnitude,0,0,-200);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("../circle_light")..{
    InitCommand=cmd(xy,-8.5,-1;blend,Blend.Add;diffuse,PlayerColor(PLAYER_1));
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffusealpha,0.5;spin;effectmagnitude,0,0,200);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};

return t;
