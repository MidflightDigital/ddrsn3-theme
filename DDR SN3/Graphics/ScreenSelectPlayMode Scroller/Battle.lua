local t = Def.ActorFrame{
  GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayBattle") end;
};

return t;
