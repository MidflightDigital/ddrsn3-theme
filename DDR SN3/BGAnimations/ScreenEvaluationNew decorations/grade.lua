--Animations for this quad are not defined here, unlike some other metrics.
local args = {...}
local pss = args[1]
local summary = args[2]
local course = args[3]
local pn = args[4]

local tier
if pss:GetFailed() then
	tier = 'Grade_Failed'
--i don't know how course grading works yet.
elseif ThemePrefs.Get "ConvertScoresAndGrades" and (not course) then
	if summary then
		--find the most popular difficulty.
		--tie behavior is that the most recent difficulty to tie wins.
		--example:
		--if you play BMBEM Medium wins. If you play MBMEB Beginner wins.
		--this is by no means accurate it's just something to have.
		local all_steps = STATSMAN:GetAccumStageStats():GetPlayerStageStats(pn):GetPlayedSteps()
		local winner = 'Difficulty_Beginner'
		local totals = {Difficulty_Beginner=0}
		for _, steps in ipairs(all_steps) do
			local diff = steps:GetDifficulty()
			local count
			if not totals[diff] then
				count = 1
			else
				count = totals[diff] + 1
			end
			totals[diff] = count
			if count > totals[winner] then
				winner = diff
			end
		end
		tier = SN2Grading.ScoreToGrade(pss:GetScore()/#all_steps, winner)
	else
		tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
	end
elseif summary then
	tier = string.format("Grade_Tier%02d",STATSMAN:GetFinalGrade(pn))
else
	tier = pss:GetGrade()
end


return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier))
}
