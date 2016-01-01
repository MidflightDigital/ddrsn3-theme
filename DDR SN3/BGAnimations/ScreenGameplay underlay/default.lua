local t = Def.ActorFrame{};

if CHARMAN:GetCharacterCount() >=1 then
t[#t+1] = LoadActor("../BGScripts")..{
	OnCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
	};
end

t[#t+1] = LoadActor("Danger");
t[#t+1] = LoadActor("ScreenFilter");

return t;