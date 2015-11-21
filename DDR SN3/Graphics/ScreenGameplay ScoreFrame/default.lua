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

	};
};

return t;