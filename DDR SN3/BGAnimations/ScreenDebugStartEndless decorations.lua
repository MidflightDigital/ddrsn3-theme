local env = GAMESTATE:Env()
GAMESTATE:SetTemporaryEventMode(true)

env.EndlessState = Endless.CreateState('StepsType_Dance_Single', ThemePrefs.Get("EndlessLevel") or 1, math.huge)

return Def.ActorFrame{Def.Actor{OnCommand=function(s) SCREENMAN:GetTopScreen():SetNextScreenName("ScreenEndlessManager"):StartTransitioningScreen("SM_GoToNextScreen") end }}