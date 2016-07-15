--ScreenDemonstration always plays a DancerVideo

local t = Def.ActorFrame{};

local function setVisibility(self)
    local song = GAMESTATE:GetCurrentSong();
    local shouldShowBGScripts = false
    if song then
        shouldShowBGScripts = not song:HasBGChanges()
        if shouldShowBGScripts then
            local opts = GAMESTATE:GetSongOptionsObject('ModsLevel_Current')
            shouldShowBGScripts = not opts:StaticBackground()
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

--Chooses one of the dancers
local choose = math.random(1,#vids);

--Sets the Dancer to be loaded
local charName = vids[choose]

local danceVid = Characters.GetDancerVideo(charName)

if danceVid then
    --Loads The Video
    t[#t+1] = LoadActor(danceVid)..{
	   InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;);	
    };
else
    --hell if i know
end

return t;