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

--old code
--[[
local charName = (GAMESTATE:Env())['SNCharacter'..
    ToEnumShortString(GAMESTATE:GetMasterPlayerNumber())] or ""

local loadWorked = false
local potentialVideo = Characters.GetDancerVideo(charName)

if potentialVideo then
    loadWorked = true
	t[#t+1] = LoadActor( potentialVideo )..{
		InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;);	
	};

end
]]

-- new code

--how often should video transitions happen?
local timePerVideo = 4

--were we able to load any videos at all?
local loadWorked = false

--load all the videos we can first, because we need to know how many we have to
--know whether to add transitions or not
local potentialVideos = {}
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do

    local charName = (GAMESTATE:Env())['SNCharacter'..
    ToEnumShortString(pn)] or ""
	local potentialVideo = Characters.GetDancerVideo(charName)

    if potentialVideo then
        loadWorked = true
        table.insert(potentialVideos, 1, potentialVideo)
    end
end

--save for later
local firstActorIndex = #t+1

for order, path in ipairs(potentialVideos) do
    t[#t+1] = LoadActor( potentialVideo )..{
        InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;diffusealpha,0);
        OnCommand=function(s) s:sleep((order*timePerVideo)-0.1)
        :linear(0.1):diffusealpha(1):linear(0):sleep(timePerVideo-0.1)
        :linear(0.1):diffusealpha(0):queuecommand("On") end,
    };        
end

--if we only added one video, just modify the actor to not transition
if #t == firstActorIndex then
    t[firstActorIndex].OnCommand = nil
end

return {bg=t, worked=loadWorked};