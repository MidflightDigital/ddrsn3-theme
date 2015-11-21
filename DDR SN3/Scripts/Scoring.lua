--This is an implementation of DDR SuperNOVA 2 and beyond scoring as described
--by Aaron Chmielowiec at http://aaronin.jp/ddrssystem.html#ss9.

--To use it, you can call PrepareScoringInfo at the start of each stage or course.

--Shared functions/data

SN2Scoring = {}
--ScoringInfo is used and maintained solely by PrepareScoringInfo.
ScoringInfo = {
    object = ""
}

local tapNoteScoresToIgnore = {
    TapNoteScore_None = true,
    TapNoteScore_CheckpointHit = true,
    TapNoteScore_CheckpointMiss = true,
    TapNoteScore_HitMine = true,
    TapNoteScore_AvoidMine = true
}

--Normal scoring

function SN2Scoring.PrepareScoringInfo()
    if GAMESTATE then
        local inCourse = GAMESTATE:IsCourseMode()
        SCREENMAN:SystemMessage("Course!")
        local maker = inCourse and SN2Scoring.MakeCourseScoringFunctions or SN2Scoring.MakeNormalScoringFunctions
        local dataFetcher = inCourse and GameState.GetCurrentTrail or GameState.GetCurrentSteps
        for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
            local data = dataFetcher(GAMESTATE,pn)
            if data then
                    SCREENMAN:SystemMessage("Found data! "..pn)
                    ScoringInfo[pn] = maker(data,pn)
            end
        end
    end
end

function SN2Scoring.MakeNormalScoringFunctions(stepsObject,pn)
    local package = {}
    local radar = stepsObject:GetRadarValues(pn)
    local baseScore = 1000000/(radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'))
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
        elseif tapNoteScore == 'TapNoteScore_W3' then
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

--Course scoring

local function CourseNoteMultiplier(stage, score)
    --if you just pass a stage number, it gives you the maximum
    score = score or 'TapNoteScore_W1'

    --the multiplier starts at 3 and goes up by 1 every two stages cleared
    local baseMultiplier = math.floor(stage-1 / 2) + 3

    if score == 'TapNoteScore_W1' or score == 'HoldNoteScore_Held' then
        return baseMultiplier
    elseif score == 'TapNoteScore_W2' then
        return baseMultiplier - 1
    elseif score == 'TapNoteScore_W3' then
        return baseMultiplier - 2
    end
    return 0
end

function SN2Scoring.MakeCourseScoringFunctions(trailObject,pn)
    local package = {}
    local trailEntries = trailObject:GetTrailEntries()
    local totalSDP = 0

    for stage, entry in ipairs( trailEntries ) do
        local multiplier = CourseNoteMultiplier(stage)
        local radar = entry:GetSteps():GetRadarValues(pn)
        totalSDP = (radar:GetValue('RadarCategory_TapsAndHolds')
            +radar:GetValue('RadarCategory_Holds')
            +radar:GetValue('RadarCategory_Rolls'))
            * multiplier
            + totalSDP
    end
    
    local baseScore = 1000000 / totalSDP
    local currentScore = 0
    local currentMaxScore = 0

    package.AddTapScore = function(tapNoteScore, stage)
        assert(stage and stage > 0, "You NEED to pass a stage number for course scoring!")
        if tapNoteScoresToIgnore[tapNoteScore] then
            return
        end
        currentMaxScore = currentMaxScore + baseScore*CourseNoteMultiplier(stage)
        currentScore = currentScore + baseScore*CourseNoteMultiplier(stage, tapNoteScore)
    end

    package.AddHoldScore = function(holdNoteScore, stage)
        assert(stage and stage > 0, "You NEED to pass a stage number for course scoring!")
        currentMaxScore = currentMaxScore + baseScore*CourseNoteMultiplier(stage)
        currentScore = currentScore + baseScore*CourseNoteMultiplier(stage, holdNoteScore)
    end

    package.GetCurrentScore = function(exact)
        if exact then
            return currentScore
        end
        return math.floor(currentScore)
    end

    package.GetCurrentMaxScore = function()
        return currentMaxScore
    end

    return package
end