local t = Def.ActorFrame{
  GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayEndless") end;
};

return t;
