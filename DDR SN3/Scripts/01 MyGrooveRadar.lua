--[[
01 MyGrooveRadar.lua
]]

--Load the setting we need for this.
local mgrData = create_setting('MyGrooveRadar','MyGrooveRadar.lua',{
    single={chaos=0,air=0,freeze=0,voltage=0,stream=0},
    double={chaos=0,air=0,freeze=0,voltage=0,stream=0}
}, 2, {})

local categoryToActorMappings = {'stream','voltage','air','freeze','chaos'}
local savedCategoryToSMCategory = {
    stream='RadarCategory_Stream',
    voltage='RadarCategory_Voltage',
    air='RadarCategory_Air',
    freeze='RadarCategory_Freeze',
    chaos='RadarCategory_Chaos'
}

MyGrooveRadar = {}

function MyGrooveRadar.PackageArbitraryRadarData(tbl, style)
    if tbl then
        local out = {}
        local myVals = tbl[style]
        if myVals then
            for idx, category in ipairs(categoryToActorMappings) do
                out[idx] = myVals[category] or 0
            end
            return out
        end
    end
    --if we did not do this it would crash!
    return {0,0,0,0,0}
end

function MyGrooveRadar.GetRadarTable(ident)
    if not mgrData:is_loaded(ident) then
        mgrData:load(ident)
    end
    return mgrData:get_data(ident)
end

function MyGrooveRadar.GetProfileIDForPlayer(pn)
    if GAMESTATE:IsHumanPlayer(pn) then
        local profile = PROFILEMAN:GetProfile(pn)
        if profile == PROFILEMAN:GetMachineProfile() then
            return "!MACHINE"
        end
        if PROFILEMAN:ProfileWasLoadedFromMemoryCard(pn) then
            return (pn=='PlayerNumber_P1') and "!MC0" or "!MC1"
        end
        if GAMESTATE:Env() then
            local pidCache = GetOrCreateChild(GAMESTATE:Env(),"PlayerLocalIDs")
            if pidCache[pn] then
                return pidCache[pn]
            end
            --worst case scenario: we have to search all the local profiles to find it.
            for _, id in pairs(PROFILEMAN:GetLocalProfileIDs()) do
                if PROFILEMAN:GetLocalProfile(id) == profile then
                    pidCache[pn] = id
                    return id
                end
            end
            --apparently this just means we're using the machine profile if this all fails.
            pidCache[pn] = "!MACHINE"
            return "!MACHINE"
        end
    end
    return "!MACHINE"
end

function MyGrooveRadar.GetRadarData(ident, style, category)
    local rData = MyGrooveRadar.GetRadarTable(ident)
    if rData[style] then
        return rData[style][category] or 0
    end
    return 0
end

function MyGrooveRadar.SetRadarData(ident, style, category, value)
    local rData = MyGrooveRadar.GetRadarTable(ident)
    if rData[style] then
        rData[style][category] = value
        mgrData:set_dirty(ident)
    end
end

function MyGrooveRadar.SaveAllRadarData()
    return mgrData:save_all()
end

function MyGrooveRadar.GetRadarDataPackaged(ident, style)
    local out = {}
    for idx, category in pairs(categoryToActorMappings) do
        out[idx] = MyGrooveRadar.GetRadarData(ident, style, category)
    end
    return out
end

function MyGrooveRadar.ApplyBonuses(ident, stageStats, styleName)
    local actualRadar = stageStats:GetRadarActual()
    local possibleRadar = stageStats:GetRadarPossible()
    for savedCat, stepsCat in pairs(savedCategoryToSMCategory) do
        local earnedValue = actualRadar:GetValue(stepsCat)*possibleRadar:GetValue(stepsCat)
        local savedValue = MyGrooveRadar.GetRadarData(ident, styleName, savedCat)
        if savedValue < earnedValue then
            MyGrooveRadar.SetRadarData(ident, styleName, savedCat, savedValue + (earnedValue-savedValue)/10)
        end
    end
end