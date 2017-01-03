local Music = ""

if ThemePrefs.Get("MenuMusic") == "SuperNOVA" then
  Music = "_sn1 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "SuperNOVA 2" then
  Music = "_sn2 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "SuperNOVA 3" then
  Music = "_sn3 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "EXTREME" then
  Music = "_extreme (loop).ogg"
end;

return THEME:GetPathS("",Music);
