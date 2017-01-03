--ScreenEndlessManager

local targetScreen = "ScreenGameplayEndless"

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
        if (stageNum % endlessState.breakAfter == 0) then
            breaking = true
            table.insert(present,LoadActor("ScreenEndlessManager break"))
        end
    end

local continuing = true
if pastStageStats then
    --we don't turn this on until the second stage so that the first stage starts with 0 combo
    PREFSMAN:SetPreference("ComboContinuesBetweenSongs", true)
    if pastStageStats:AllFailed() then
        PREFSMAN:SetPreference("ComboContinuesBetweenSongs", false)
        continuing = false
        targetScreen = "ScreenGameOver"
    end
end

if continuing then
    --get and set up the next song
    local nextUp = endlessState.choiceDeck()

    GAMESTATE:SetCurrentSong(nextUp[1])
    GAMESTATE:SetCurrentSteps(GAMESTATE:GetMasterPlayerNumber(), nextUp[2])
end

--if this is a break stage, the input callback will continue for us instead
if not breaking then
    table.insert(present,Def.Actor{OnCommand=function(s) SCREENMAN:GetTopScreen():SetNextScreenName(targetScreen):StartTransitioningScreen("SM_GoToNextScreen") end })
end

return present