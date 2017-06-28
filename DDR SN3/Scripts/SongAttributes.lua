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
local function group_name_to_path(group_name)
    local tests = {
        "/Songs/"..group_name,
        "/AdditionalSongs/"..group_name
    }
    for i,v in ipairs(tests) do
        if FILEMAN:DoesFileExist(v) then
            return v
        end
    end
end

local function split_and_trim(sep, txt)
    local tbl = split(sep, txt)
    for k, v in pairs(tbl) do
        tbl[k] = v:gsub("^%s*",""):gsub("%s*$","")
    end
    return tbl
end

local function song_specific_dir(song)
    local parts = split_and_trim("/", song:GetSongDir())
    return parts[#parts]
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
        output[tag:lower()] = split_and_trim(":",content)
    end

    return output
end

local function get_or_prepare(group)
    if data_map[group] then return data_map[group] end
    local path = group_name_to_path(group)
    assert(path, "can't find data for this group")
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
            if check and check >= 0 and check <= 1 then
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
    return {split_and_trim("|", text)}
end

-- more involved functions

--/\default and /\valid are chosen because they are impossible song dir names on any platform

local function internal_menucolor(group)
    local group_data = get_or_prepare(group)
    if type(group_data.menucolor) == "table" and group_data.menucolor["/\\valid"] then
        return group_data.menucolor
    end
    if (not group_data.menucolor) or next(group_data.menucolor) == nil then
        group_data.menucolor = {["/\\default"]={1,1,1,0}, ["/\\valid"]=true}
        return group_data.menucolor
    end
    local new_menucolor = {["/\\valid"]=true, ["/\\default"]={1,1,1,0}}
    for _, data in pairs(group_data.menucolor) do
        local temp_storage = parse_rgba(data)
        if temp_storage then
            new_menucolor["/\\default"] = temp_storage
        end
        temp_storage = parse_list(data)
        if #temp_storage >= 2 then
            --there must be at least a color and a song
            local provisional_color = parse_rgba(temp_storage[1])
            if provisional_color then
                for i=2,#temp_storage do
                    new_menucolor[tolower(temp_storage[i])] = provisional_color
                end
            end
        end
    end
    group_data.menucolor = new_menucolor
    return new_menucolor
end


function SongAttributes.GetMenuColor(song)
    local group = song:GetGroupName()
    local mc_data = internal_menucolor(group)
    return mc_data[tolower(song_specific_dir())] or mc_data["/\\default"]
end
