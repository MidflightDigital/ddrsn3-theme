Characters = {}
local c = Characters

local requiredFiles = {"combo.png", "combo100.png"}

local rootPath = "/SNCharacters/"

--Loads the file at path and runs it in the specified environment,
--or an empty one if no environment is provided. Catches any errors that occur.
--Returns false if the called function failed, true and anything else the function returned if it worked
local function dofile_safer(path, env)
    env = env or {}
    if not FILEMAN:DoesFileExist(path) then
        --the file doesn't exist
        return false
    end
    local handle = RageFileUtil.CreateRageFile()
    handle:Open(path, 1)
    local code = loadstring(handle:Read(), path)
    handle:Close()
    handle:destroy()
    if not code then
        --an error occurred while compiling the file
        return false
    end
    setfenv(code, env)
    return pcall(code)
end


--Returns the base path for a character or none if that character doesn't exist.
function Characters.GetPath(name)
    if string.find(name, "/") then
        return nil
    end
    local charPath = rootPath..name.."/"
    if FILEMAN:DoesFileExist(charPath) then
        return charPath
    end
end

--Characters.GetConfig is cached.
--It returns the configuration if it is valid, nothing if not.
local ClearConfigCache
do

local characterConfigs = {}

local function ValidateAndProcessConfig(loadedCfg)
    if not (loadedCfg.version and loadedCfg.color) then
        return false, "missing field"
    end
    if (loadedCfg.version < 1) then
        return false, "invalid version field"
    end
    if (loadedCfg.version > 1) then
        return false, "version too new"
    end
    local colorDef = loadedCfg.color
    local colorType = type(colorDef)
    if not ((colorType=="string") or (colorType == "table")) then
        return false, "color is not a string or table"
    end
    if (colorType == "table") and (#colorDef ~= 4) then
        return false, "invalid color table size"
    end
    if (colorType=="string") then
        loadedCfg.color = color(colorDef)
    end
    return true
end

--This function actually does the work, Characters.GetConfig just decides
--whether the cached value can be used or not
local function GetConfigInternal(name)
    local charPath = c.GetPath(name)
    if charPath then
        local configPath = charPath.."config.lua"
        if FILEMAN:DoesFileExist(configPath) then
            local result = {dofile_safer(configPath)}
            if result[1] and (type(result[2]) == "table") then
                --ValidateAndProcessConfig works in place, so it doesn't need
                --to return anything
                if ValidateAndProcessConfig(result[2]) then
                    return result[2]
                end
            end
        end
    end
    --Though Characters.GetConfig returns nil on a bad configuration, Lua doesn't
    --distinguish absent table values from nil table values, so this returns false
    --and Characters.GetConfig turns that back into nil.
    return false
end

function Characters.GetConfig(name, forceRecheck)
    if (characterConfigs[name]~=nil and (not forceRecheck)) then
        Trace("returning from cache for "..name)
        return (characterConfigs[name]~=false) 
            and characterConfigs[name]
            or nil
    else
        local cfg = GetConfigInternal(name)
        characterConfigs[name] = cfg
        return (cfg ~= false) and cfg or nil
    end
end

ClearConfigCache = function() characterConfigs = {} end

end
--!!end Characters.GetConfig!!

--Characters.Validate is cached because I feel like it could take a while.
--Returns true if a character is valid, false if not.
local ClearValidateCache
do

local characterValidity = {}

--This function actually does the work, Characters.Validate just decides whether
--the cached value can be used or not
local function ValidateInternal(name)
    local charPath = c.GetPath(name)
    if charPath then
        --presumably we want to recheck the config every time we actually run
        if c.GetConfig(name, true) then
            for fileName in ivalues(requiredFiles) do
                if not FILEMAN:DoesFileExist(charPath..fileName) then
                    return false
                end
            end
            return true
        end
    end
    return false
end

function Characters.Validate(name, forceRecheck)
    if (characterValidity[name]~=nil and (not forceRecheck)) then
        return characterValidity[name]
    else
        local status = ValidateInternal(name)
        characterValidity[name] = status
        return status
    end
end

ClearValidateCache = function() characterValidity = {} end

end
--!!end Characters.Validate!!


--Returns a table with every character name in it, unvalidated.
function Characters.GetAllPotentialCharacterNames()
    local output = FILEMAN:GetDirListing(rootPath, true, false)
    table.sort(output)
    return output
end

function Characters.GetAllCharacterNames()
    local potentials = c.GetAllPotentialCharacterNames()
    local output = {}
    for charName in ivalues(potentials) do
        if c.Validate(charName) then
            table.insert(output, charName)
        end
    end
    return output
end

--Returns a dancer video or nothing if none exist.
function Characters.GetDancerVideo(name)
    local potentialVideos = {} 
    local charPath = c.GetPath(name)
    if charPath then
        charPath = charPath .. "DancerVideos/"
        local listing = FILEMAN:GetDirListing(charPath, false, true)
        if not listing then return nil end
        for _, file in pairs(listing) do
            if ActorUtil.GetFileType(file) == 'FileType_Movie' then
                table.insert(potentialVideos,file)
            end
        end
    end
    if #potentialVideos ~= 0 then
        return potentialVideos[math.random(1,#potentialVideos)]
    end
end

if SN3Debug then
    Trace("potential characters: "..table.concat(c.GetAllPotentialCharacterNames(), " "))
    Trace("valid characters: "..table.concat(c.GetAllCharacterNames(), " "))
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