local x = Def.ActorFrame{};

local stype = GAMESTATE:GetCurrentStyle():GetStyleType()
local styleName = ((stype == 'StyleType_OnePlayerTwoSides') or (stype == 'StyleType_TwoPlayersSharedSides'))
		and 'double'
		or 'single'
for _, plr in pairs(GAMESTATE:GetEnabledPlayers()) do
	local profileID = GetProfileIDForPlayer(plr)
	if profileID ~= "!MACHINE" then
		local shortPn = ToEnumShortString(plr)
		local pPrefs = ProfilePrefs.Read(profileID)
		pPrefs.filter = getenv("ScreenFilter"..shortPn) or 0
		pPrefs.character = (GAMESTATE:Env())["SNCharacter"..shortPn] or ""
		MyGrooveRadar.ApplyBonuses(profileID, STATSMAN:GetCurStageStats():GetPlayerStageStats(plr), styleName)
		ProfilePrefs.Save(profileID)
	end
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