--Special Features for SuperNOVA styled themes (Inorizushi)

--SelectMusic Positions

function WideSSM()
  if Var "LoadingScreen" == "ScreenSelectMusicExtra" then
    return true
  end
  return ThemePrefs.Get("XStyledMusicSelect") == "Wide Style"
end 

SelectMusicXPositions = 
{
  Style = {SCREEN_LEFT+33, SCREEN_CENTER_X-282},
  Diff = {SCREEN_LEFT+120, SCREEN_CENTER_X-200},
  DiffBG = {SCREEN_LEFT+163, SCREEN_CENTER_X-157},
  ModP1 = {SCREEN_LEFT+109, SCREEN_CENTER_X-211},
  ModP2 = {SCREEN_LEFT+300, SCREEN_CENTER_X-20},
  Grades = {SCREEN_RIGHT-40, SCREEN_CENTER_X+280},
  Banner = {SCREEN_LEFT+141, SCREEN_CENTER_X - 179},
  BannerFrame = {SCREEN_LEFT+152, SCREEN_CENTER_X - 168},
  CD = {SCREEN_LEFT+250, SCREEN_CENTER_X-70},
  Stage = {SCREEN_LEFT+160, SCREEN_CENTER_X-160},
  BPMNum = {SCREEN_LEFT+250, SCREEN_CENTER_X-70},
  BPMMeter = {SCREEN_LEFT+284, SCREEN_CENTER_X-36},
  Radar = {SCREEN_LEFT + 149, SCREEN_CENTER_X-171},
  NewSong = {SCREEN_RIGHT-304, SCREEN_CENTER_X+16},
  Balloon = {SCREEN_RIGHT-240, SCREEN_CENTER_X+80},
  Wheel = {SCREEN_RIGHT-166, SCREEN_CENTER_X+154},
  WheelBG = {SCREEN_RIGHT, SCREEN_CENTER_X+380},
  HighlightBG = {SCREEN_RIGHT, SCREEN_CENTER_X+320}
}

for name, entry in pairs(SelectMusicXPositions) do
  _G[name.."PosX"] = function()
    return WideSSM() and entry[1] or entry[2]
  end
end

function RadarPosX()
  if Var "LoadingScreen" == "ScreenSelectMusicExtra" then
    return SCREEN_LEFT + 139
  else
    local entry = SelectMusicXPositions.Radar
    return WideSSM() and entry[1] or entry[2]
  end
end

function WheelScrollOn(self)
  local DO = 99
  if ThemePrefs.Get("XStyledMusicSelect") == "Wide Style" then
    self:draworder(DO)
    self:x(156)
  else
    self:draworder(DO)
    self:x(263)
  end
end
