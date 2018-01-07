local args = {...}
local pss = args[1]
local onCommand = args[2]
local offCommand = args[3]

local tier
if ThemePrefs.Get "FakeGrades" then
	tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
else
	tier = pss:GetGrade()
end


return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier)),
	OnCommand = onCommand,
	OffCommand = offCommand
}
