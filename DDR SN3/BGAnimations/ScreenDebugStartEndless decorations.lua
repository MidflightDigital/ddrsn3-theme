local env = GAMESTATE:Env()
GAMESTATE:SetTemporaryEventMode(true)

env.EndlessState = Endless.CreateState('StepsType_Dance_Single', 3, 5)

env.EndlessState.startingCC = PREFSMAN:GetPreference("ComboContinuesBetweenSongs")

PREFSMAN:SetPreference("ComboContinuesBetweenSongs", true)

return Def.ActorFrame{Def.Actor{OnCommand=function(s) SCREENMAN:GetTopScreen():SetNextScreenName("ScreenEndlessManager"):StartTransitioningScreen("SM_GoToNextScreen") end }}