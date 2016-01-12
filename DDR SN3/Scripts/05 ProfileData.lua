ProfileData = {}

--Here's the structure of the data 

local themeTableName = 'MidflightDigital-SN3'
local radarTableName = 'MyGrooveRadar'

--This comes in handy in a number of places
function GetOrCreateChild(tab, field, kind)
    kind = kind or 'table'
    local out
    if not tab[field] then
        if kind == 'table' then
            out = {}
        elseif kind == 'number' then
            out = 0
        elseif kind == 'boolean_df' or kind == 'boolean' then
            out = false
        elseif kind == 'boolean_dt' then
            out = true
        else
            error("GetOrCreateChild: I don't know a default value for type "..kind)
        end
        tab[field] = out
    else out = tab[field] end
    return out
end

--Returns the theme table if it exists, creates it if it doesn't.
function ProfileData.GetThemeTable(prf)
    if prf then
        local uTab = prf:GetUserTable()
        local tTab = GetOrCreateChild(uTab, 'theme')
        return GetOrCreateChild(tTab, themeTableName)
    end
end

function ProfileData.GetRadarData(prf, style, category)
    if prf then
        local rTab = ProfileData.GetRadarTable(prf)
        local sTab = rTab[style]
        if not sTab then
            ProfileData.ImportRadarData(prf)
            sTab = rTab[style]
        end
        return GetOrCreateChild(sTab, category, 'number')
    end
end

function ProfileData.SetRadarData(prf, style, category, value)
    assert(value and tonumber(value) and value >= 0, "SetRadarData: invalid value!")
    local rTab = ProfileData.GetRadarTable(prf)
    local sTab = rTab[style]
    if not sTab then
        ProfileData.ImportRadarData(prf)
        sTab = rTab[style]
    end
    sTab[category] = value
end

local styleMappings = {S='single',D='double'}
local categoryMappings = {'stream','voltage','air','freeze','chaos'}

function ProfileData.GetRadarTable(prf)
    if prf then
        local uTab = prf:GetUserTable()
        local sTab = GetOrCreateChild(uTab, 'shared')
        return GetOrCreateChild(sTab, radarTableName)
    end
end

--I define 'packaged' radar data as radar data ready to be fed into a Def.GrooveRadar.
function ProfileData.GetRadarDataPackaged(prf, style)
    local out = {}
    for idx, category in pairs(categoryMappings) do
        out[idx] = ProfileData.GetRadarData(prf, style, category)
    end
    return out
end

--Imports the original file-based MyGrooveRadar format.
--Will always overwrite the profile with MyGrooveRadar data 
--You can call this directly but GetRadarData calls it if it has to.
--It might be a nice menu option somewhere.
function ProfileData.ImportRadarData(prf)
    if prf then
        local radarTab = ProfileData.GetRadarTable(prf)
        local f = RageFileUtil.CreateRageFile()
        local prefix = "/Save/MyGrooveRadar/"..prf:GetGUID().."_"
        for fStyle, tStyle in pairs(styleMappings) do
            local styleTab = GetOrCreateChild(radarTab, tStyle)
            for fCat, tCat in pairs(categoryMappings) do
                if f:Open(prefix..fStyle..fCat..".txt", 1) then
                    local contents = tonumber(f:Read())
                    if contents then styleTab[tCat] = contents
                    elseif not styleTab[tCat] then styleTab[tCat] = 0
                    end
                    f:Close()
                end
            end
        end
        f:destroy()
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