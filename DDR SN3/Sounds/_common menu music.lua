local Music = ""

if ThemePrefs.Get("MenuMusic") == "SuperNOVA" then
  Music = "_sn1 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "SuperNOVA 2" then
  Music = "_sn2 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "SuperNOVA 3" then
  Music = "_sn3 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "EXTREME" then
  Music = "_extreme (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "IIDX SIRIUS" then
  Music = "_SIRIUS MENU (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "DDRMAX 2" then
  Music = "_MAX2 (loop).ogg"
elseif ThemePrefs.Get("MenuMusic") == "DDRMAX" then
  Music = "_MAX (loop).ogg"
end;

return THEME:GetPathS("",Music);
