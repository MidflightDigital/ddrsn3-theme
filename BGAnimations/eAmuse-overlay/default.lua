local t = Def.ActorFrame{
  LoadActor("box")..{
    InitCommand=cmd(Center);
    OnCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");
  };
};

return t;
