local t = Def.ActorFrame{
	LoadActor("mid")..{
		InitCommand=cmd(CenterX);
	};
	LoadActor("frame1p")..{
		BeginCommand=cmd(queuecommand,"CheckNumPlayers1");
		InitCommand=cmd(halign,0;x,SCREEN_LEFT);
		CheckNumPlayers2Command=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:visible(false)
			end
		end;
	};
	LoadActor("frame1p")..{
		BeginCommand=cmd(queuecommand,"CheckNumPlayers2");
		InitCommand=cmd(halign,0;x,SCREEN_RIGHT;zoomx,-1);
		CheckNumPlayers2Command=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:visible(false)
			end
		end;
	};
	Def.TextBanner{
		InitCommand = function(self) self:Load("TextBannerGameplay")
        	:SetFromSong(GAMESTATE:GetCurrentSong())
        	:x(SCREEN_CENTER_X-100):y(-8)
        end;
        CurrentSongChangedMessageCommand = function(self)
        	self:SetFromSong(GAMESTATE:GetCurrentSong())
        end;
	};
};

return t;