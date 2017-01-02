local t = Def.ActorFrame{
  InitCommand=cmd(y,-10);
  LoadActor("confirm")..{
    InitCommand=cmd(x,SCREEN_RIGHT-71;halign,1);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("select")..{
    InitCommand=cmd(x,SCREEN_RIGHT-183;halign,1);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("difficulty")..{
    InitCommand=cmd(x,SCREEN_RIGHT-115;y,20;halign,1);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("sort")..{
    InitCommand=cmd(x,SCREEN_RIGHT-125;halign,1);
    OnCommand=cmd(diffuseblink;effectcolor1,1,1,1,1;effectcolor2,0,0,0,0;effectperiod,2;);
  };
};

return t;
