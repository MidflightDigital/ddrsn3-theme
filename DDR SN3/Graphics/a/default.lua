local Player = ...
if not Player then error("ScreenEvaluation PersonalRecord requires a Player") end

return Def.ActorFrame{
	Def.Sprite{
		BeginCommand=function(self)
			local curStageStats = STATSMAN:GetCurStageStats()
			local pss = curStageStats:GetPlayerStageStats(Player)
			local personalHighIndex = pss:GetPersonalHighScoreIndex()
			if personalHighIndex > -1 and personalHighIndex < 10 then
				self:Load(THEME:GetPathG("ScreenEvaluation","PersonalRecord/"..string.format("%02d",personalHighIndex+1)))
			end
		end;
	};
};