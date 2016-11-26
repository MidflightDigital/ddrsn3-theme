local t = Def.ActorFrame{};
local screenName = Var "LoadingScreen"

if screenName == "ScreenSelectMusic" or screenName == "ScreenSelectCourse" then
  t[#t+1] = Def.ActorFrame{
    LoadActor("Normal");
  };
else
  t[#t+1] = Def.ActorFrame{
    LoadActor("Extra");
  };
end;

return t
