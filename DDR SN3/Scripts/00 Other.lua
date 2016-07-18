--This comes in handy in a number of places
function GetOrCreateChild(tab, field, kind)
    kind = kind or 'table'
    local out
    if not tab[field] then
        if kind == 'table' then
            out = {}
        elseif kind == 'number' then
            out = 0
        elseif kind == 'boolean_df' or kind == 'boolean' then
            out = false
        elseif kind == 'boolean_dt' then
            out = true
        else
            error("GetOrCreateChild: I don't know a default value for type "..kind)
        end
        tab[field] = out
    else out = tab[field] end
    return out
end

SN3Debug = FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory().."debug.txt")
if SN3Debug then
	print("SN3 debug mode enabled.")
end

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

	Title:maxwidth(300/0.8)
	Title:y(-7)
	Title:zoom(0.8)

	Subtitle:visible(false)

	Artist:maxwidth(300/0.6)
	Artist:y(9)
	Artist:zoom(0.6)

end

function TextBannerGameplayAfterSet(self, param)
	TextBannerAfterSet(self)
	self:GetChild("Title"):maxwidth(200/0.8)
	self:GetChild("Artist"):maxwidth(200/0.6)
end

local difficultyToIconIndex = {
	Difficulty_Beginner		= 0,
	Difficulty_Easy			= 1,
	Difficulty_Medium		= 2,
	Difficulty_Hard			= 3,
	Difficulty_Challenge 	= 4,
	Difficulty_Edit			= 5
}
function GetDifficultyIconFrame(diff) return difficultyToIconIndex[diff] or difficultyToIconIndex['Difficulty_Edit'] end

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

-- JoinStringsWithSpace(a, b)
-- Joins a pair of strings by a space, removing other whitespace around it.
function JoinStringsWithSpace(a, b)
	return a:gsub("%s*$","").." "..b:gsub("^%s*","")
end

function ToastyTriggersAt(_, level)
	if level == 0 then
		--the code that loads the toasty triggers appears to add 1 to this value.
		--and ONLY this value.
		return 24
	elseif level == 1 then
		return 25
	else
		return 50
	end
end

--MakeDeck(source)
--Takes a table and returns a deck based on that table.
--A deck is a function that, when it is called, returns a random value from
--a table. It will go through every entry in the table before repeating. 
function MakeDeck(source)
	assert(source, "MakeDeck: you need to pass in a table")
	if not next(source) then
		Warn("MakeDeck: got empty table, returning NOTHING!!!")
		return nil
	end
	local keys = nil
	local function FindKeys()
		keys = {}
		for key, _ in pairs(source) do
			table.insert(keys, key)
		end
	end
	FindKeys()
	return function()
		if next(keys) == nil then FindKeys() end
		return source[table.remove(keys, ((#keys == 1) and 1 or math.random(1,#keys)))]
	end
end

function EnableStarterGameplayJunk()
	assert(GAMESTATE and GAMESTATE:Env(), 
		"Wherever you are calling EnableStarterGameplayJunk, you can't do it there!")
	local env = GAMESTATE:Env()
	env.StarterMode = true
end

--It turns out that past tertu fucked this function up.
--A fix will probably hit 5.1 but for now we're going to do this.
function ThemeManager:GetAbsolutePath(sPath)
	sFinPath = "/Themes/"..self:GetCurThemeName().."/"..sPath
	assert(FILEMAN:DoesFileExist(sFinPath), "the theme element "..sPath.." is missing")
	return sFinPath
end

local videoRenderers = split(",",PREFSMAN:GetPreference("VideoRenderers"))
if videoRenderers[1] == "d3d" then
	Warn("Direct3D mode detected. Some visual effects may not work properly.\nDo not report these problems as bugs, they are limitations of Direct3D mode.")
end