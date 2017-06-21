--SongAttributes.lua
--reads waiei's group.ini format (http://sm.waiei.net/other/group.html)
--written with reference to waiei's readers

local notes_detection = false
if SN3Debug then
    notes_detection = true
end

SongAttributes = {}

local data_map = {}

--these functions deal with loading

--specifically, group name to group.ini path
local function song_path_to_path(song_path)
    return song_path:gsub("/.*$", "").."/group.ini"
end


--actually converts the text into a table
local function parse(text)

    --right now this tolerates things the original readers don't and doesn't
    --tolerate things the original readers do but if you make your files right
    --there shouldn't be a problem

    --step 1: remove comments
    text = text:gsub("^//.-\n", ""):gsub("\n//.-\n","")

    --step 2: collect and split tags
    local output = {}
    --right now this supports multiple tags per line. DON'T DO THIS!
    for tag, content in text:gmatch("#(%w+):(.-);") do
        local final_content = split(":",content)
        for _, element in pairs(final_content) do
            --delete leading and trailing whitespace
            element = element:gsub("^%s*",""):gsub("%s*$","")
        end
        output[tag:lower()] = final_content
    end

    return output, notes_check_passed
end

local function get_or_prepare(song)
    local group = song:GetGroupName()
    if data_map[group] then return data_map[group] end
    local path = song_path_to_path(song:GetSongDir())
    local result = {}
    if FILEMAN:DoesFileExist(path) then
        local f = RageFileUtil.CreateRageFile()
        f:Open(path, 1)
        local text = f:Read()
        f:Close()
        f:destroy()
        result = parse(text)
    end
    data_map[group] = result
    return result
end

--functions for dealing with commonly used data items

local function parse_rgba(text)
    local output = split(",", text)
    if #output == 4 then
        for k, v in pairs(output) do
            local check = tonumber(v)
            if check then
                output[k] = check
            else
                return nil
            end
        end
        return output
    end
    return nil
end

local function parse_list(text)
    return split("|", text)
end
