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

-- (c) 2016 John Walstrom
-- All rights reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, and/or sell copies of the Software, and to permit persons to
-- whom the Software is furnished to do so, provided that the above
-- copyright notice(s) and this permission notice appear in all copies of
-- the Software and that both the above copyright notice(s) and this
-- permission notice appear in supporting documentation.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
-- THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS
-- INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT
-- OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
-- OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
-- PERFORMANCE OF THIS SOFTWARE.