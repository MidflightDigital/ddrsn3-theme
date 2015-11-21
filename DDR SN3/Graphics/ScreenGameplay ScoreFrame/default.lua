local t = Def.ActorFrame{
	LoadActor("mid");
	LoadActor("frame")..{
		BeginCommand=cmd(queuecommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:cropleft(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropright(0.5)
			end
		end;
	};
	Def.TextBanner{
		BeginCommand=cmd(queuecommand,"CheckGameMode");
		CheckGameModeCommand=function(self,param)
			if GAMESTATE:IsCourseMode() == true then
				self:Load("TextBannerGameplay")
					:SetFromCourse(GAMESTATE:GetCurrentCourse())
					:x(-100):y(-8)
			elseif GAMESTATE:IsCourseMode() == false then
				self:Load("TextBannerGameplay")
					:SetFromSong(GAMESTATE:GetCurrentSong())
					:x(-100):y(-8)
			end
		end;
	};
};

return t;