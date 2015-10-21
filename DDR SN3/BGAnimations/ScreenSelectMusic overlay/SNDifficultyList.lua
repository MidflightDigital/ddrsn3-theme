local function LoadMetric(name, isBoolean)
    local metricValue = THEME:GetMetric("SNDifficultyList", name)
    assert(metricValue, "SNDifficultyList: can't load metric "..name)
    --only numbers and booleans are supported
    if isBoolean then
        return (metricValue == "true") or (metricValue=="1")
    else
        local n = tonumber(metricValue)
        assert(n, "SNDifficultyList: metric "..name.." must be a number but is not")
        return n
    end
end

local difficultiesToDraw = {
    'Difficulty_Beginner',
    'Difficulty_Easy',
    'Difficulty_Medium',
    'Difficulty_Hard',
    'Difficulty_Challenge'
}

local invDifficultiesToDraw = {}
for k, v in pairs(difficultiesToDraw) do
    invDifficultiesToDraw[v] = k
end

--[[
local glowFeet = LoadMetric "GlowIfMeterAbove10"
local tickPos = LoadMetric "TickPositionX"
local startPos = LoadMetric "StartPositionY"]]
local startPos = LoadMetric "StartPositionY"
local itemSpacingY = LoadMetric "ItemSpacingY"
local labelPos = LoadMetric "LabelPositionX"

local lastSong = nil
local lastSteps = {PlayerNumber_P1=nil, PlayerNumber_P2=nil}

local function Update(self, _)
    if GAMESTATE then
        local song = GAMESTATE:GetCurrentSong()
        local steps = {}
        local anyStepsChanged = false
        for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
            steps[pn] = GAMESTATE:GetCurrentSteps(pn)
            if steps[pn] ~= lastSteps[pn] then anyStepsChanged = true break end
        end
        if (song~=lastSong) or anyStepsChanged then
            for _, row in pairs(self:GetChildren()) do
                for _, item in pairs(self:GetChildren()) do
                    item:queuecommand("Update")
                end
            end
        end
        lastSong = song
        lastSteps = steps
    end
end

local ret = Def.ActorFrame{InitCommand=function(self) self:xy(SCREEN_LEFT+120,SCREEN_CENTER_Y+90):SetUpdateFunction(Update) end}

for idx, diff in pairs(difficultiesToDraw) do
    local element = Def.ActorFrame{
        Name = "Row"..diff,
        InitCommand = function(self) self:y( startPos + ( itemSpacingY*( idx-1 ) ) ) end,
        Def.Sprite{
            Name = "Label",
            Texture = "SNDifficultyList labels 1x6.png",
            InitCommand = function(self) self:setstate(idx-1):SetAllStateDelays(math.huge):x(labelPos):diffuse{0.5,0.5,0.5,1} end,
            UpdateCommand=function(self)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    local anyPlayerThisDiff = false
                    for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
                        if GAMESTATE:GetCurrentSteps(pn):GetDifficulty()==diff then anyPlayerThisDiff = true break end
                    end
                    if anyPlayerThisDiff then
                        self:diffuse(CustomDifficultyToColor(ToEnumShortString(diff)))                        
                    elseif song:HasStepsTypeAndDifficulty(GAMESTATE:GetCurrentStyle():GetStepsType(), diff) then
                        self:diffuse{1,1,1,1}
                    else
                        self:diffuse{0.5,0.5,0.5,1}
                    end
                end
            end
        }

    }
    table.insert(ret, element)
end

return ret