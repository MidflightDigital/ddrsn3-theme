--A set of functions that are used very heavily in ScreenSelectProfile
--and ScreenDataSaveSummary.
RadarHelpers = {}

local styleMappings = {S='single',D='double'}
local categoryMappings = {'stream','voltage','air','freeze','chaos'}

function RadarHelpers.PackageArbitraryRadarData(tbl, style)
    if tbl then
        local out = {}
        local myVals = tbl[style]
        if myVals then
            for idx, category in ipairs(categoryMappings) do
                out[idx] = myVals[category]
            end
            return out
        end
    end
    --if we did not do this it would crash!
    return {0,0,0,0,0}
end

do
    local hpFormatString = "_ability/%.3d"
    function RadarHelpers.GetHonorPicturePath(percentage)
        percentage = 2*math.floor(clamp(percentage, 0, 100)/2)
        return THEME:GetPathB("",hpFormatString:format(percentage))
    end
end

do
    --macaron. y chacarron.
    local honorTitles = {'Stone','Soap Bubble','Pencil','Macaron','Lotus',
        'Beetle','Jellyfish','Hummingbird','Kaleidoscope','Prism'}
    function RadarHelpers.GetHonorTitle(percentage)
        percentage = clamp(percentage,0,100)
        if percentage==0 then
            return '--'
        end
        local idx = math.max(1,math.ceil(percentage/10))
        return honorTitles[idx]
    end
end