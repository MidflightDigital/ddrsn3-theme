--[[
ProfilePrefs
Values and their meanings:
guidelines: whether beat lines should be shown
character: the name of the character that should be used.
filter: the screen filter darkness that should be used.
lanes: whether lane boundaries should be shown or not.
bias: whether the early/late indicator should be shown.
]]
local profilePrefs = create_setting('ProfilePrefs','ProfilePrefs.lua',
	{
		guidelines = false,
		character = "",
		filter = 0,
		lanes = false,
		bias = false
	}
, 1, {})