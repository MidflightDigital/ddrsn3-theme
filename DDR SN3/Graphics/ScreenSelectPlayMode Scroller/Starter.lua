local t = Def.ActorFrame{
  GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayStarter") end;
};

return t;
