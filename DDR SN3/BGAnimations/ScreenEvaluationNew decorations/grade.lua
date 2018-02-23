--Animations for this quad are not defined here, unlock some other metrics.
local args = {...}
local pss = args[1]

local tier
if pss:GetFailed() then
	tier = 'Grade_Failed'
elseif ThemePrefs.Get "FakeGrades" then
	tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
else
	tier = pss:GetGrade()
end


return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier))
}
