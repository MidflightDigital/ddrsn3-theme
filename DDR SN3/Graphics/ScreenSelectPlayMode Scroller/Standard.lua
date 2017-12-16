local t = Def.ActorFrame{
  GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayStandard") end;
};

return t;
