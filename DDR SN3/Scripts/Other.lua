function TextBannerAfterSet(self,param) 
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")
	local Artist=self:GetChild("Artist")

	if Subtitle:GetText() ~= "" then
		--strip off whitespace at the beginning of the subtitle text
		--and the end of the title text
		local SubtitleText = Subtitle:GetText()
		local TitleText = Title:GetText()
		Title:settext(JoinStringsWithSpace(TitleText, SubtitleText))
	end

	Title:maxwidth(350/0.75)
	Title:y(-7)
	Title:zoom(0.75)

	Subtitle:visible(false)

	Artist:maxwidth(350/0.65)
	Artist:y(9)
	Artist:zoom(0.65)

end

function TextBannerGameplayAfterSet(self, param)
	TextBannerAfterSet(self)
	self:GetChild("Title"):maxwidth(200/0.75)
	self:GetChild("Artist"):maxwidth(200/0.65)
end

function GetDifficultyIconFrame(diff) return (Enum.Reverse 'Difficulty')[diff] or 5 end

function LoadStepsDisplayGameplayFrame(self,player)
	local difficultyStates = {
		Difficulty_Beginner	 = 0,
		Difficulty_Easy		 = 2,
		Difficulty_Medium	 = 4,
		Difficulty_Hard		 = 6,
		Difficulty_Challenge = 8,
		Difficulty_Edit		 = 10,
	};
	local selection;
	if GAMESTATE:IsCourseMode() then
		-- get steps of current course entry
		selection = GAMESTATE:GetCurrentTrail(player);
		local entry = selection:GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()+1)
		selection = entry:GetSteps()
	else
		selection = GAMESTATE:GetCurrentSteps(player);
	end;
	local diff = selection:GetDifficulty()
	local state = difficultyStates[diff] or 10;
	if player == PLAYER_2 then state = state + 1; end;
	return state;
end;

function Actor:scale_or_crop_background()
	if PREFSMAN:GetPreference("StretchBackgrounds") then
		self:cropto(SCREEN_WIDTH, SCREEN_HEIGHT)
	else
		local graphicAspect = self:GetWidth()/self:GetHeight()
		self:zoomto(SCREEN_HEIGHT*graphicAspect,SCREEN_HEIGHT)
	end
end

-- summary evaluation banner handling (for 1-5 stages)
-- ganked from my ddr 5th mix port
local summaryBannerX = {
	MaxStages1 = { SCREEN_CENTER_X },
	MaxStages2 = {
		SCREEN_CENTER_X+45,
		SCREEN_CENTER_X-45
	},
	MaxStages3 = {
		SCREEN_CENTER_X+60,
		SCREEN_CENTER_X,
		SCREEN_CENTER_X-60
	},
	MaxStages4 = {
		SCREEN_CENTER_X+45,
		SCREEN_CENTER_X+15,
		SCREEN_CENTER_X-15,
		SCREEN_CENTER_X-45
	},
	MaxStages5 = {
		SCREEN_CENTER_X+60,
		SCREEN_CENTER_X+30,
		SCREEN_CENTER_X,
		SCREEN_CENTER_X-30,
		SCREEN_CENTER_X-60
	}
}

local summaryBannerY = {
	MaxStages1 = { SCREEN_CENTER_Y-140 },
	MaxStages2 = {
		SCREEN_CENTER_Y-130,
		SCREEN_CENTER_Y-150
	},
	MaxStages3 = {
		SCREEN_CENTER_Y-120,
		SCREEN_CENTER_Y-140,
		SCREEN_CENTER_Y-160
	},
	MaxStages4 = {
		SCREEN_CENTER_Y-125,
		SCREEN_CENTER_Y-135,
		SCREEN_CENTER_Y-145,
		SCREEN_CENTER_Y-155
	},
	MaxStages5 = {
		SCREEN_CENTER_Y-120,
		SCREEN_CENTER_Y-130,
		SCREEN_CENTER_Y-140,
		SCREEN_CENTER_Y-150,
		SCREEN_CENTER_Y-160
	}
}

function GetSummaryBannerX(num)
	local maxStages = PREFSMAN:GetPreference('SongsPerPlay')

	-- check how many stages were played...
	local playedStages = STATSMAN:GetStagesPlayed()
	if playedStages < maxStages then
		-- long versions and/or marathons were involved.
		if playedStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerX.MaxStages4[num]
		end
	elseif playedStages > maxStages then
		-- extra stages
		if playedStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerX.MaxStages4[num]
		elseif playedStages == 5 then return summaryBannerX.MaxStages5[num]
		end
	else
		-- normal behavior
		if maxStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif maxStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif maxStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif maxStages == 4 then return summaryBannerX.MaxStages4[num]
		elseif maxStages == 5 then return summaryBannerX.MaxStages5[num]
		end
	end
end

function GetSummaryBannerY(num)
	local maxStages = PREFSMAN:GetPreference('SongsPerPlay')

	-- check how many stages were played...
	local playedStages = STATSMAN:GetStagesPlayed()
	if playedStages < maxStages then
		-- long versions and/or marathons were involved.
		if playedStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerY.MaxStages4[num]
		end
	elseif playedStages > maxStages then
		-- extra stages
		if playedStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerY.MaxStages4[num]
		elseif playedStages == 5 then return summaryBannerY.MaxStages5[num]
		end
	else
		-- normal behavior
		if maxStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif maxStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif maxStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif maxStages == 4 then return summaryBannerY.MaxStages4[num]
		elseif maxStages == 5 then return summaryBannerY.MaxStages5[num]
		end
	end
end

-- GetCharAnimPath(sPath)
-- Easier access to Characters folder (taken from ScreenHowToPlay.cpp)
function GetCharAnimPath(sPath) return "/Characters/"..sPath end

-- JoinStringsWithSpace(a, b)
-- Joins a pair of strings by a space, removing other whitespace around it.
function JoinStringsWithSpace(a, b)
	return a:gsub("%s*$","").." "..b:gsub("^%s*","")
end