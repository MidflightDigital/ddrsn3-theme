local env = GAMESTATE:Env()
GAMESTATE:SetTemporaryEventMode(true)

env.EndlessState = Endless.CreateState('StepsType_Dance_Single', 4, 5)

SCREENMAN:SystemMessage("holy FUCKQUE it Worked")

return Def.ActorFrame{OnCommand=function(s) SCREENMAN:SetNewScreen( 'ScreenEndlessManager' ) end }