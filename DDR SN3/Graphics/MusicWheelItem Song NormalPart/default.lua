local t = Def.ActorFrame{};
local screenName = Var "LoadingScreen"

if screenName == "ScreenSelectMusicExtra" then
  t[#t+1] = Def.ActorFrame{
    LoadActor("Extra");
  };
else
  t[#t+1] = Def.ActorFrame{
    LoadActor("Normal");
  };
end;

return t
