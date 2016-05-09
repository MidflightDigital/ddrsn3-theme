CharacterExtras = {}
local c = CharacterExtras

local rootPath = THEME:GetCurrentThemeDirectory().."/Characters/"

--Returns the base path for a character or none if that character doesn't exist.
function CharacterExtras.GetPath(name)
    if CHARMAN:GetCharacter(name) then
        local charPath = rootPath..name.."/"
        if FILEMAN:DoesFileExist(charPath) then
            return charPath
        end
    end
end

--Returns a dancer video or nothing if none exist.
function CharacterExtras.GetDancerVideo(name)
    local potentialVideos = {} 
    local charPath = c.GetPath(name)
    if charPath then
        charPath = charPath .. "DancerVideos/"
        local listing = FILEMAN:GetDirListing(charPath, false, true)
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