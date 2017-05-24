local Music = ""

if ThemePrefs.Get("MenuMusic") == "IIDX SIRIUS" then
  Music = "_SIRIUS MODE (loop).ogg"
else
  Music = "_common menu music.lua"
end;

return THEME:GetPathS("",Music);
