local t = Def.ActorFrame{
  LoadActor("p2_right")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};

if ThemePrefs.Get("LightMode") == false
t[#t+1] = Def.ActorFrame{
  LoadActor("../side_light")..{
    InitCommand=cmd(x,-22);
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffuseshift;blend,Blend.Add;effectcolor1,color("1,0,0.9,0.5");effectcolor2,color("0,0,0,0");effectclock,'beatnooffset');
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};
end;

t[#t+1] = Def.ActorFrame{
  LoadActor("p2_cursor")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};

if ThemePrefs.Get("LightMode") == false then
t[#t+1] = Def.ActorFrame{
  LoadActor("../circle_light")..{
    InitCommand=cmd(xy,8.5,-1;blend,Blend.Add;diffuse,PlayerColor(PLAYER_2));
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffusealpha,0.5;spin;effectmagnitude,0,0,-200);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("../circle_light")..{
    InitCommand=cmd(xy,8.5,-1;blend,Blend.Add;diffuse,PlayerColor(PLAYER_2));
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;diffusealpha,0.5;spin;effectmagnitude,0,0,200);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};
end;

return t;
