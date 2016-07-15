local Prefs =
{
	AutoSetStyle =
	{
		Default = false,
		Choices = { "ON", "OFF" },
		Values = { true, false }
	},
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
--[[
function OptionRowCharSel()
	local t = {
		Name="CharacterSel"
		LayoutType = "ShowAllInRow"
		SelectTyle = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'), 'Alice', 'Baby-Lon', 'Disco', 'Emi', 'Jenny', 'Rage', 'Yuni', },
		LoadSelections = function(self, list, pn)
			local pName= ToEnumShortString(pn)
			local 
--]]
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

function ReadOrCreateScreenFilterValueForPlayer(PlayerUID, MyValue)
	local FilterFile = RageFileUtil:CreateRageFile()
	if FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",1) then 
		local str = FilterFile:Read();
		MyValue =tonumber(str);
	else
		FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
		FilterFile:Write("0");
		MyValue=0;
	end
	FilterFile:Close();
	return MyValue;
end

function SaveScreenFilterValueForPlayer( PlayerUID, MyValue)
	-- local FilterFile = RageFileUtil:CreateRageFile();
	-- if FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",1) then 
		-- local str = FilterFile:Read();
		-- MyValue = tonumber(str);
	-- else
		-- FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
		-- FilterFile:Write("0");
	-- end
	-- FilterFile:Close();
	
	local FilterFile2 = RageFileUtil:CreateRageFile();
	FilterFile2:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
	FilterFile2:Write(tostring(MyValue));
	FilterFile2:Close();
end


function OptionRowScreenFilterUseFile()
	local t = {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'), '0.25', '0.5', '0.75', '1.0', },
		LoadSelections = function(self, list, pn)
			--local pName = ToEnumShortString(pn)
			--local filterValue = getenv("ScreenFilter"..pName)
			local filterValue = 0;
			local pf = PROFILEMAN:GetProfile(pn);
			local PlayerUID = "";
			
			if pf then 
				PlayerUID = pf:GetGUID()  
				filterValue = ReadOrCreateScreenFilterValueForPlayer(PlayerUID,filterValue);
			else
				PlayerUID = "UnknownPlayerUID"
				filterValue = 0;
			end
			
			if filterValue ~= nil then
				local val = scale(tonumber(filterValue),0,1,1,#list )
				list[val] = true
			else
				--setenv("ScreenFilter"..pName,0)
				SaveScreenFilterValueForPlayer(PlayerUID,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			local PlayerUID = "";
			local pf = PROFILEMAN:GetProfile(pn);
			
			if pf then 
				PlayerUID = pf:GetGUID()  
			else
				PlayerUID = "UnknownPlayerUID"
			end
			
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = scale(i,1,#list,0,1)
						setenv("ScreenFilter"..pName,val)
						SaveScreenFilterValueForPlayer(PlayerUID,val)
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end
