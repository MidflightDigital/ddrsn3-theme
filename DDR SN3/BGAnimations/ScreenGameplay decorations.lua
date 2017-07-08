local t = Def.ActorFrame{};

t[#t+1] = StandardDecorationFromFileOptional("StageFrame","StageFrame");
t[#t+1] = StandardDecorationFromFile("LifeFrame","LifeFrame")
t[#t+1] = StandardDecorationFromFile("ScoreFrame","ScoreFrame")

-- stage display (normal)
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")

local ScoringPlayers = {}

local tns_reverse = Enum.Reverse(TapNoteScore)

t[#t+1] = Def.Actor{
    Name="ScoringController",
    JudgmentMessageCommand = function(_,params)
		SN2Scoring.PrepareScoringInfo(IsStarterMode())
        if not ScoringPlayers[params.Player] then
            ScoringPlayers[params.Player] = true
        end
		--worstJudge is used by the combo code
		if not ScoringInfo.worstJudge then
			ScoringInfo.worstJudge = {}
		end
		local wj = ScoringInfo.worstJudge[params.Player]
		if (not wj) or tns_reverse[params.TapNoteScore] < tns_reverse[wj] then
			ScoringInfo.worstJudge[params.Player] = params.TapNoteScore
		end
        local es = (GAMESTATE:Env()).EndlessState
        if es then
            local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player)
            es.scoring.handleNoteScore(params.HoldNoteScore or params.TapNoteScore,
                GAMESTATE:GetCurrentStageIndex()+1,
                pss:GetCurrentCombo())
            --SCREENMAN:SystemMessage(es.scoring.getScoreString())
        end
    end,
}

local function ScoreUpdate()
    for pn, _ in pairs(ScoringPlayers) do
        local info = ScoringInfo[pn]
        local stage = GAMESTATE:IsCourseMode() and GAMESTATE:GetCourseSongIndex() + 1 or nil
        local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
        local score = info.GetCurrentScore(pss, stage)
        pss:SetScore(score)
        local scoreDisplay = SCREENMAN:GetTopScreen():GetChild("Score"..ToEnumShortString(pn))
        if scoreDisplay then
            scoreDisplay:GetChild("Text"):targetnumber(score)
        end
        pss:SetCurMaxScore(info.GetCurrentMaxScore(pss, stage))
    end
end

t[#t+1] = Def.ActorFrame{
    Name = "ScoringController2",
    InitCommand = function(s) s:SetUpdateFunction(ScoreUpdate) end
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
