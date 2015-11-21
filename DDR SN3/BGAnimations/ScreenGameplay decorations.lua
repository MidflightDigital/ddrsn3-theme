local t = Def.ActorFrame{};

t[#t+1] = StandardDecorationFromFileOptional("StageFrame","StageFrame");
t[#t+1] = StandardDecorationFromFile("LifeFrame","LifeFrame")
t[#t+1] = StandardDecorationFromFile("ScoreFrame","ScoreFrame")

-- stage display (normal)
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")

-- stage display (course)
if ShowStandardDecoration("StageNumber") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local stageNum = LoadActor(THEME:GetPathG(Var "LoadingScreen", "StageNumber"), pn)
		t[#t+1] = StandardDecorationFromTable( "StageNumber" .. ToEnumShortString(pn), stageNum );
	end
end

t[#t+1] = Def.Actor{
    Name="ScoringController",
    JudgmentMessageCommand = function(_,params)
        if not (( ScoringInfo[params.Player]) or 
            (ScoringInfo.seed == GAMESTATE:GetStageSeed())) then 
            SN2Scoring.PrepareScoringInfo()
            ScoringInfo.seed = GAMESTATE:GetStageSeed() 
        end
        local stage = GAMESTATE:IsCourseMode() and GAMESTATE:GetCourseSongIndex() + 1 or nil
        local info = ScoringInfo[params.Player]
        if params.HoldNoteScore then
            info.AddHoldScore(params.HoldNoteScore, stage)
        else
            info.AddTapScore(params.TapNoteScore, stage)
        end
        local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player)
        pss:SetScore(info.GetCurrentScore())
        pss:SetCurMaxScore(info.GetCurrentMaxScore())
    end,
}

return t