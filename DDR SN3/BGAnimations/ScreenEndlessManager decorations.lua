--ScreenEndlessManager

local endlessState = (GAMESTATE:Env()).Endless
if not endlessState then
    error("EndlessManager: not ready")
end
