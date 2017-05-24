local Prefs =
{
	XStyledMusicSelect =
	{
		Default = "Wide Style",
		Choices = { "X Style", "Wide Style" },
		Values = { "X Style", "Wide Style" }
	},
	XDifficultyList =
	{
		Default = "SN Style",
		Choices = { "X Style", "SN Style"},
		Values = { "X Style", "SN Style"}
	},
	EndlessLevel =
	{
		Default = 1,
		Choices = { "Lv. 1", "Lv. 2", "Lv. 3", "Lv. 4", "All", "Lv. 5" },
		Values = {1, 2, 3, 4, 5, 6}
	},
	JudgmentHeight =
	{
		Default = "Standard",
		Choices = {"Standard", "Old"},
		Values = {"Standard", "Old"}
	},
	MenuBG =
	{
		Default = "SuperNOVA 3",
		Choices = { "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS" },
		Values = { "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS" }
	},
	MenuMusic =
	{
		Default = "SuperNOVA 3",
		Choices = { "EXTREME", "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS" },
		Values = { "EXTREME", "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS" }
	}
}

ThemePrefs.InitAll(Prefs)

function InitUserPrefs()
	local Prefs = {
		UserPrefGameplayShowStepsDisplay = true,
		UserPrefGameplayShowStepsDisplay = true,
		UserPrefGameplayShowScore = false,
		UserPrefShowLotsaOptions = true,
		UserPrefAutoSetStyle = false,
		UserPrefLongFail = false,
		UserPrefNotePosition = true,
		UserPrefComboOnRolls = false,
		UserPrefProtimingP1 = false,
		UserPrefProtimingP2 = false,
		FlashyCombos = false,
		UserPrefComboUnderField = true,
		UserPrefFancyUIBG = true,
		UserPrefTimingDisplay = true
	}
	for k, v in pairs(Prefs) do
		-- kind of xxx
		local GetPref = type(v) == "boolean" and GetUserPrefB or GetUserPref
		if GetPref(k) == nil then
			SetUserPref(k, v)
		end
	end

	-- screen filter
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
end

function OptionRowScreenFilter()
	--we use integers equivalent to the alpha value multiplied by 10
	--to work around float precision issues
	local choiceToAlpha = {0, 3, 6, 9}
	local alphaToChoice = {[0]=1, [3]=2, [6]=3, [9]=4}
	local t = {
		Name="Filter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionTitles', 'FilterDark'),
			THEME:GetString('OptionTitles', 'FilterDarker'),
			THEME:GetString('OptionTitles', 'FilterDarkest'),
		 },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)

			if filterValue ~= nil then
				local val = alphaToChoice[filterValue] or 1
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						setenv("ScreenFilter"..pName,choiceToAlpha[i])
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end
local judgmentTransformYs = {
	Standard={normal=-76, reverse=67},
	Old={normal=-30, reverse=30}
}
setmetatable(judgmentTransformYs, {__index=function(this, _) return this.Standard end})

function JudgmentTransformCommand( self, params )
	self:x( 0 )
	self:y( judgmentTransformYs
		[ThemePrefs.Get("JudgmentHeight")]
		[params.bReverse and "reverse" or "normal"] )
end
