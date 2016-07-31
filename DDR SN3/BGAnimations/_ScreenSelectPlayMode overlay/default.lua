local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
    LoadActor("standard")..{
      InitCommand=cmd(halign,0;x,WideScale(SCREEN_LEFT,SCREEN_LEFT+80);y,SCREEN_BOTTOM-80);
      OnCommand=cmd();
      
