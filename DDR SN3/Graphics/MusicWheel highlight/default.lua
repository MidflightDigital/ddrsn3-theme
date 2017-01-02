local t = Def.ActorFrame{};
local screenName = Var "LoadingScreen"

if screenName ~= "ScreenSelectMusicExtra" then
  t[#t+1] = Def.ActorFrame{
    LoadActor("Normal");
  };
else
  t[#t+1] = Def.ActorFrame{
    LoadActor("Extra");
  };
end;

return t
