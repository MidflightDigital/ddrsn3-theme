local t = Def.ActorFrame{
	LoadActor("mid")..{
		InitCommand=cmd(CenterX);
	};
	Def.TextBanner{
		InitCommand = function(self) self:Load("TextBannerGameplay")
        	:x(SCREEN_CENTER_X-100):y(-8)
        	if GAMESTATE:GetCurrentSong() then
        		self:SetFromSong(GAMESTATE:GetCurrentSong())
        	end
        end;
        CurrentSongChangedMessageCommand = function(self)
        	self:SetFromSong(GAMESTATE:GetCurrentSong())
        end;
	};
};

--P1 Score Frame
t[#t+1]=Def.ActorFrame{
	BeginCommand=cmd(queuecommand,"CheckNumPlayer1");
	CheckNumPlayers1Command=function(self,param)
		if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
			self:visible(false)
		end
	end;
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT-3;setsize,193,23);
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,190,20;diffuse,color("0,0,0,1"));
	};
};
t[#t+1]=Def.ActorFrame{
	BeginCommand=cmd(queuecommand,"CheckNumPlayer2");
	CheckNumPlayers1Command=function(self,param)
		if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
			self:visible(false)
		end
	end;
	Def.Quad{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT+3;setsize,199,23);
	};
	Def.Quad{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT+3;setsize,190,20;diffuse,color("0,0,0,1"));
	};
};

return t;
