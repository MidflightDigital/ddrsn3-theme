--This is an arbitrary-precision integer based implementation
--of the DDR X endless scoring method.
EndlessScoring = {}

local levelLookup = {3, 6, 8, 10}

local MAX_SCORE = bn.Int(string.rep('9',30))
function EndlessScoring.Create(level)
    local three = bn.Int(3)
    local score = bn.Int(bn.zero)
    local w1Counter = bn.Int(bn.zero)
    local noteCounter = bn.Int(bn.zero)
    local penaltyCounter = bn.Int(bn.zero)
    local tnsReverse = Enum.Reverse(PlayerNumber)
    local lastCombo = 0
    return {
    handleNoteScore = function(noteScore, stageNumber, curCombo)
        if score < MAX_SCORE then
            noteCounter = noteCounter + bn.one
            
            if noteScore == 'TapNoteScore_W1' then
                w1Counter = w1Counter + bn.one
            elseif tnsReverse[noteScore] and 
                tnsReverse[noteScore] < tnsReverse['TapNoteScore_W3']
            then
                penaltyCounter = penaltyCounter + bn.Int(lastCombo/4)
            end

            local levelFactor
            if level == 1 then
                levelFactor = bn.Int(2*(stageNumber^3))
            else
                levelFactor = bn.Int(stageNumber^3/levelLookup[level])
            end

            local effectiveNotes = noteCounter - penaltyCounter
            if noteScore == 'TapNoteScore_W1' then
                score = score + (three * (effectiveNotes+w1Counter) * levelFactor )
            elseif noteScore == 'TapNoteScore_W2' or noteScore == 'HoldNoteScore_Held' then
                score = score + (bn.two * effectiveNotes * levelFactor)
            elseif noteScore == 'TapNoteScore_W3' then
                score = score + effectiveNotes * levelFactor
            end

            if score > MAX_SCORE then score = bn.Int(MAX_SCORE) end
            lastCombo = curCombo
        end
    end,
    getScoreString= function()
        return score:tostring()
    end
    }
end

Endless = {}

function Endless.GetSongChartBlock(stepsType, minLevel, maxLevel)
    local ret = {}
    assert(minLevel <= maxLevel)
    for _, song in pairs(SONGMAN:GetAllSongs()) do
        if UNLOCKMAN:IsSongLocked(song) == 0 then
            for _, steps in pairs(song:GetStepsByStepsType(stepsType)) do
                if not (steps:GetDifficulty() == 'Difficulty_Edit') then
                    local meter = steps:GetMeter()
                    if (meter >= minLevel) and (meter <= maxLevel) then
                        table.insert(ret, {song, steps})
                    end
                end
            end
        end
    end
    return ret
end

local levelToRange = {
    {1,3},
    {3,5},
    {5,7},
    {7,9},
    {1,11}
}

function Endless.CreateState(stepsType, endlessLevel, breakStages)
    assert((breakStages > 0) and stepsType and (endlessLevel >= 1) and (endlessLevel <= 5))
    local minLevel, maxLevel = unpack(levelToRange[endlessLevel])
    return {scoring=EndlessScoring.Create(endlessLevel), 
        choiceDeck = MakeDeck(Endless.GetSongChartBlock(stepsType, minLevel, maxLevel)),
        breakAfter=breakStages}
end