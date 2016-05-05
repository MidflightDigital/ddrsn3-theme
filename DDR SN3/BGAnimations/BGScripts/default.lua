--DO NOT TRY TO LOAD THIS ACTOR DIRECTLY!!
--IT WILL NOT WORK!!

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

local charName = GAMESTATE:GetCharacter(GAMESTATE:GetMasterPlayerNumber()):GetDisplayName();
local rmax = 9;
local num = math.random(1);

local loadWorked = false

if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/BGScripts/" .. charName .. "_" .. num .. ".avi") then
    loadWorked = true
	t[#t+1] = LoadActor( charName .. "_" .. num .. ".avi" )..{
		InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;);	
	};

end
	
return {bg=t, worked=loadWorked};