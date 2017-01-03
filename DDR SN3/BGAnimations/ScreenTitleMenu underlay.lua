InitUserPrefs();
local t = Def.ActorFrame{
  OnCommand=function(self)
    if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
      Trace("ThemePrefs doesn't exist; creating file")
      ThemePrefs.ForceSave()
    end
    if SN3Debug then
      SCREENMAN:SystemMessage("Saving ThemePrefs.")
    end
    ThemePrefs.Save()
  end;
};

t[#t+1] = Def.ActorFrame{
  OnCommand=function(self)
    if SN3Debug then
      print("setlife:"..tostring(Player.SetLife));
    end
  end
};

return t;
