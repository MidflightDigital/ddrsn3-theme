local Player = ...
if not Player then error("ScreenEvaluation MachineRecord requires a Player") end

return Def.ActorFrame{
	Def.Sprite{
		BeginCommand=function(self)
			local curStageStats = STATSMAN:GetCurStageStats()
			local pss = curStageStats:GetPlayerStageStats(Player)
			local machineHighIndex = pss:GetMachineHighScoreIndex()
			if machineHighIndex > -1 and machineHighIndex < 10 then
				self:Load(THEME:GetPathG("ScreenEvaluation","MachineRecord/"..string.format("%02d",machineHighIndex+1)))
			end
		end;
	};
};