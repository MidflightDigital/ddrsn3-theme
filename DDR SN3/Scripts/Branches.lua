function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function CorrectSSM()
	if IsStarterMode() then
		return "ScreenSelectMusicStarter"
	else
		return "ScreenSelectMusic"
	end
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return CorrectSSM()
	end
end

Branch.Init = function() return "ScreenInit" end

Branch.AfterInit = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		return Branch.TitleMenu()
	else
		return "ScreenLogo"
	end
end

Branch.TitleMenu = function()
	-- home mode is the most assumed use of sm-ssc.
	if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
		return "ScreenTitleMenu"
	end
	-- arcade junk:
	if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
		-- if no credits are inserted, don't show the Join screen. SM4 has
		-- this as the initial screen, but that means we'd be stuck in a
		-- loop with ScreenInit. No good.
		return "ScreenTitleJoin"
	else
		return "ScreenTitleJoin"
	end
end

Branch.StartGame = function()
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if PROFILEMAN:GetNumLocalProfiles() >=1 then
		return "ScreenSelectProfile"
	else
		return "ScreenCaution"
	end
end

Branch.Net = function()
	if IsNetSMOnline() then
		return SMOnlineScreen()
	else
		return "ScreenCaution"
	end
end

Branch.AfterSMOLogin = SMOnlineScreen()

Branch.BackOutOfPlayerOptions = function()
	return SelectMusicOrCourse()
end

Branch.InstructionsNormal = function()
	return PREFSMAN:GetPreference("ShowInstructions") and "ScreenInstructions" or CorrectSSM()
end

Branch.AfterInstructions = function()
	return GAMESTATE:IsCourseMode() and "ScreenSelectCourse" or CorrectSSM()
end

Branch.GameplayScreen = function()
	if IsRoutine() then
		return "ScreenGameplayShared"
	elseif GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
		return "ScreenGameplayExtra"
	end
	return "ScreenGameplay"
end

Branch.AfterGameplay = function()
	if IsNetSMOnline() then
		-- even though online mode isn't supported in this theme yet
		return "ScreenNetEvaluation"
	else
		if GAMESTATE:IsCourseMode() then
			if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
				return "ScreenEvaluationNonstop"
			else	-- oni and endless are shared
				return "ScreenEvaluationOni"
			end
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			return "ScreenEvaluationRave"
		else
			return "ScreenEvaluationNormal"
		end
	end
end

Branch.AfterEvaluation = function()
	--normal
	if GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() >= 1 then
		return "ScreenProfileSave"
	elseif GAMESTATE:GetCurrentStage() == "Stage_Extra1" then
		if STATSMAN:GetCurStageStats():AllFailed() then
			return "ScreenEvaluationSummary"
		else
			return "ScreenProfileSave"
		end;
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenProfileSaveSummary"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenProfileSaveSummary"
	else
		return "ScreenEvaluationSummary"
	end
end

Branch.AfterSummary = "ScreenProfileSaveSummary"

Branch.Network = function()
	return IsNetConnected() and "ScreenTitleMenu" or "ScreenTitleMenu"
end

Branch.AfterSaveSummary = function()
	if PROFILEMAN:GetNumLocalProfiles() >= 1 then
		return "ScreenDataSaveSummary"
	else
		return "ScreenGameOver"
	end
end

Branch.AfterDataSaveSummary = function()
	if GAMESTATE:AnyPlayerHasRankingFeats() then
		return "ScreenDataSaveSummaryEnd"
	else
		return "ScreenDataSaveSummaryEnd"
	end
end


-- pick an ending screen
Branch.Ending = function()
	if GAMESTATE:IsEventMode() then
		return SelectMusicOrCourse()
	end
	-- best final grade better than AA: show the credits.
	-- otherwise, show music scroll.
	return STATSMAN:GetBestFinalGrade() <= 'Grade_Tier03' and "ScreenCredits" or "ScreenMusicScroll"
end
