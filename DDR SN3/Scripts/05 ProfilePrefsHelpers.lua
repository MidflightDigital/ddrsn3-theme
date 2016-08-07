local entryToPrefixMap = {
	['filter'] = "ScreenFilter",
	['character'] = "SNCharacter"
}

local function d(text)
	if SN3Debug then
		return print("ProfilePrefsHelpers: "..text)
	end
end

function LoadFromProfilePrefs()
	local env = GAMESTATE:Env()
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		d("processing "..pn)
		local prefs = ProfilePrefs.Read(GetProfileIDForPlayer(pn))
		local shortPn = ToEnumShortString(pn)
		for sourceName, destName in pairs(entryToPrefixMap) do
			destName = destName..shortPn
			if env[destName] then
				d(destName.." already present, skipping "..sourceName)
			else
				env[destName] = prefs[sourceName]
				d("moved "..sourceName.." to "..destName)
			end
		end
	end
	d("done")
end 
