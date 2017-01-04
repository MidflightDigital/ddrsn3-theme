local t = Def.ActorFrame{
  LoadActor("closed")..{
    InitCommand=cmd(Center);
  };
};

return t;
