--ScreenDemonstration always plays a DancerVideo

local t = Def.ActorFrame{};

local visibilityOverride = nil

local function setVisibility(self)
    local song = GAMESTATE:GetCurrentSong();
    local shouldShowBGScripts = visibilityOverride or false
    if visibilityOverride == nil then
        if song then
            shouldShowBGScripts = not song:HasBGChanges()
            if shouldShowBGScripts then
                local opts = GAMESTATE:GetSongOptionsObject('ModsLevel_Current')
                shouldShowBGScripts = not opts:StaticBackground()
            end
        end
    end
    local bg = SCREENMAN:GetTopScreen():GetChild("SongBackground")
    if bg then
        bg:visible(not shouldShowBGScripts);
    end
    self:visible(shouldShowBGScripts);
end

t.OnCommand = setVisibility
t.CurrentSongChangedMessageCommand = setVisibility

--Set a table for possible dancers
local vids = Characters.GetAllCharacterNames();

if #vids > 0 then

    local danceVid = nil
    repeat
        --Chooses one of the dancers
        local choose = table.remove(vids,(#vids == 1) and 1 or math.random(1,#vids))

        --Sets the Dancer to be loaded
        local charName = vids[choose]

        danceVid = Characters.GetDancerVideo(charName)
    until (danceVid ~= nil) or (#vids == 0)

    if danceVid then
        --Loads The Video
        t[#t+1] = LoadActor(danceVid)..{
	   InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;);	
        };
    else
        visibilityOverride = false
    end
end

return t;
