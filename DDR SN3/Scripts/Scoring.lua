--This is an implementation of DDR SuperNOVA 2 and beyond scoring as described
--by Aaron Chmielowiec at http://aaronin.jp/ddrssystem.html#ss9.

SN2Scoring = {}

local tapNoteScoresToIgnore = {
    TapNoteScore_None = true,
    TapNoteScore_CheckpointHit = true,
    TapNoteScore_CheckpointMiss = true,
    TapNoteScore_HitMine = true,
    TapNoteScore_AvoidMine = true,
}

function SN2Scoring.MakeNormalScoringFunctions(stepsObject)
    local package = {}
    local baseScore = 1000000/stepsObject:GetRadarValues():GetValue('RadarCategory_TapsAndHolds')
    local currentScore = 0
    local currentMaxScore = 0

    package.AddTapScore = function(tapNoteScore)
        if tapNoteScoresToIgnore[tapNoteScore] then
            return
        end
        currentMaxScore = currentMaxScore + baseScore
        if tapNoteScore == 'TapNoteScore_W1' then
            currentScore = currentScore + baseScore
        elseif tapNoteScore == 'TapNoteScore_W2' then
            currentScore = currentScore + (baseScore - 10)
        elseif tapNoteScore == 'TapNoteScore_W3'
            currentScore = currentScore + (baseScore / 2 - 10)
        end
    end

    package.AddHoldScore = function(holdNoteScore)
        currentMaxScore = currentMaxScore + baseScore
        if holdNoteScore == 'HoldNoteScore_Held' then
            currentScore = currentScore + baseScore
        end
    end

    package.GetCurrentScore = function(exact)
        if exact then
            return currentScore
        end
        return 10 * math.floor(currentScore / 10)
    end

    package.GetCurrentMaxScore = function()
        return currentMaxScore
    end

    return package
end