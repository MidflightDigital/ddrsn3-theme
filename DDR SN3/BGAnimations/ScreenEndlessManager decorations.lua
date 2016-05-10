--ScreenEndlessManager

local present = Def.ActorFrame{}

local endlessState = (GAMESTATE:Env()).EndlessState
if not endlessState then
    error("EndlessManager: not ready")
end

if GAMESTATE:GetNumPlayersEnabled() > 1 then
    error("EndlessManager: Endless is a 1 player mode")
end

local pastStageStats = STATSMAN:GetPlayedStageStats(1)
    if pastStageStats then
        local stageNum = pastStageStats:GetStageIndex()+1
        if (endlessState.breakAfter % stageNum == 0) then
            table.insert(present,LoadActor("ScreenEndlessManager break"))
        end
    end
end

local nextUp = endlessState.choiceDeck()

GAMESTATE:SetCurrentSong(nextUp[1])
GAMESTATE:SetCurrentSteps(GAMESTATE:GetMasterPlayerNumber(), nextUp[2])