local t = Def.ActorFrame{
  GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayCourse") end;
};

return t;
