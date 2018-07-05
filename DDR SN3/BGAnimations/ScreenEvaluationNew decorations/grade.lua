--Animations for this quad are not defined here, unlike some other metrics.
local args = {...}
local pss = args[1]
local summary = args[2]
local pn = args[3]

local tier
if summary then
	tier = string.format("Grade_Tier%02d",STATSMAN:GetFinalGrade(pn))
elseif pss:GetFailed() then
	tier = 'Grade_Failed'
elseif ThemePrefs.Get "ConvertScoresAndGrades" then
	tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
else
	tier = pss:GetGrade()
end


return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier))
}
