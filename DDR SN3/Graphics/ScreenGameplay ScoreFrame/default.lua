local t = Def.ActorFrame{
	LoadActor("mid");
	LoadActor("frame1")..{
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:IsPlayerEnabled(0) == false then
				self:visible(false)
			end
		end;
	};
	LoadActor("frame2")..{
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:IsPlayerEnabled(1) == false then
				self:visible(false)
			end
		end;
	};
	Def.TextBanner{
		InitCommand = function(self) self:Load("TextBanner")
        	:SetFromSong(GAMESTATE:GetCurrentSong())
        	:x(-95):y(-8)
        end;
	};
};

return t;