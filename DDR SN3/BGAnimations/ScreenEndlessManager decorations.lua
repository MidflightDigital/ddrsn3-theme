--ScreenEndlessManager

local present = Def.ActorFrame{}

local endlessState = (GAMESTATE:Env()).EndlessState
if not endlessState then
    error("EndlessManager: not ready")
end

if GAMESTATE:GetNumPlayersEnabled() > 1 then
    error("EndlessManager: Endless is a 1 player mode")
end

--if this is a break stage, we need to show the break stuff
local breaking = false
local pastStageStats = STATSMAN:GetPlayedStageStats(1)
    if pastStageStats and false then
        local stageNum = pastStageStats:GetStageIndex()+1
        if (endlessState.breakAfter % stageNum == 0) then
            breaking = true
            table.insert(present,LoadActor("ScreenEndlessManager break"))
        end
    end
end

--get and set up the next song
local nextUp = endlessState.choiceDeck()

GAMESTATE:SetCurrentSong(nextUp[1])
GAMESTATE:SetCurrentSteps(GAMESTATE:GetMasterPlayerNumber(), nextUp[2])

--if this is a break stage, the input callback will continue for us instead
if not breaking then
    SCREENMAN:SetNewScreen( 'ScreenGameplayEndless' )
end

return present