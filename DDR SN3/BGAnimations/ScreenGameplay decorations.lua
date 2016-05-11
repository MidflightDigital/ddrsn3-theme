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
        if not (( ScoringInfo[params.Player]) and 
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
        local es = (GAMESTATE:Env()).EndlessState
        if es then
            es.scoring.handleNoteScore(params.HoldNoteScore or params.TapNoteScore,
                GAMESTATE:GetCurrentStageIndex()+1,
                pss:GetCurrentCombo())
            SCREENMAN:SystemMessage(es.scoring.getScoreString())
        end
    end,
}

t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
	InitCommand=cmd(player,PLAYER_1;zoom,1.4;x,WideScale(SCREEN_LEFT+140,SCREEN_LEFT+140);draworder,1);
	OnCommand=function(self)
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
			self:y(SCREEN_TOP+70);
		else
			self:y(SCREEN_BOTTOM-70);
		end;
	end;
};
t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
	InitCommand=cmd(player,PLAYER_2;zoom,1.4;x,WideScale(SCREEN_RIGHT-140,SCREEN_RIGHT-140);draworder,1);
	OnCommand=function(self)
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
			self:y(SCREEN_TOP+70);
		else
			self:y(SCREEN_BOTTOM-70);
		end;
	end;
};

return t