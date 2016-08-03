local x = Def.ActorFrame{};

local stype = GAMESTATE:GetCurrentStyle():GetStyleType()
local styleName = ((stype == 'StyleType_OnePlayerTwoSides') or (stype == 'StyleType_TwoPlayersSharedSides'))
		and 'double'
		or 'single'
for _, plr in pairs(GAMESTATE:GetEnabledPlayers()) do
	local profileID = GetProfileIDForPlayer(plr)
	MyGrooveRadar.ApplyBonuses(profileID, STATSMAN:GetCurStageStats():GetPlayerStageStats(plr), styleName)
end
MyGrooveRadar.SaveAllRadarData()
ProfilePrefs.SaveAll()

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};


return x;