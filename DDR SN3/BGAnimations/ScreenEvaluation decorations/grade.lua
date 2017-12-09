local args = {...}
-- the only arg is arg 1, the player number

local function m(metric)
	metric = metric:gsub("PN", ToEnumShortString(args[1]))
	return THEME:GetMetric(Var "LoadingScreen",metric)
end

local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(args[1])

local tier
if ThemePrefs.Get "FakeGrades" then
	tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
else
	tier = pss:GetGrade()
end

if SN3Debug then
	SCREENMAN:SystemMessage(("pn: %s fake grades: %s tier: %s"):format(args[1],tostring(ThemePrefs.Get "FakeGrades"), tier))
end

return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier)),
	InitCommand = function(s) s:x(m "GradePNX"):y(m "GradePNY") end,
	OnCommand = m "GradePNOnCommand",
	OffCommand = m "GradePNOffCommand"
}
