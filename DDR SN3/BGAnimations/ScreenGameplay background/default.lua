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
	SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(not shouldShowBGScripts);
	self:visible(shouldShowBGScripts);
end

if CHARMAN:GetCharacterCount() >=1 then
t[#t+1] = LoadActor("../BGScripts")..{
	OnCommand=setVisibility,
	CurrentSongChangedMessageCommand=setVisibility
};
end

return t;