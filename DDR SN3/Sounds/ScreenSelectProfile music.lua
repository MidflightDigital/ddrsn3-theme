local Music = ""

if ThemePrefs.Get("MenuMusic") == "IIDX SIRIUS" then
  Music = "_SIRIUS PROFILE (loop).ogg"
else
  Music = "_SN3 PROFILE (loop).ogg"
end;

return THEME:GetPathS("",Music);
