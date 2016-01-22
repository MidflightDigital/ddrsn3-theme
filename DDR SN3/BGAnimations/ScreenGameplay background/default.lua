local t = Def.ActorFrame{};

if CHARMAN:GetCharacterCount() >=1 then
t[#t+1] = LoadActor("../BGScripts")..{
	OnCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(true);
		self:visible(false);
		else
		SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(false);
		self:visible(true);
		end;
		end;
	end;
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(true);
		self:visible(false);
		else
		SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(false);
		self:visible(true);
		end;
		end;
	end;
	};
end

return t;