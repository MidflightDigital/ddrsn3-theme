local env = GAMESTATE:Env()
GAMESTATE:SetTemporaryEventMode(true)

env.EndlessState = Endless.CreateState('StepsType_Dance_Single', 3, 5)

PREFSMAN:SetPreference("ComboContinuesBetweenSongs", true)

SCREENMAN:SystemMessage("holy FUCKQUE it Worked")

return Def.ActorFrame{Def.Actor{OnCommand=function(s) SCREENMAN:GetTopScreen():SetNextScreenName("ScreenEndlessManager"):StartTransitioningScreen("SM_GoToNextScreen") end }}