return Def.ActorFrame{
  LoadActor("vector")..{
    InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-60;zoom,0;);
    OnCommand=cmd(sleep,0.4;linear,0.198;zoom,0.5);
    OffCommand=cmd(sleep,0.4;linear,0.198;zoom,0);
  };
};
