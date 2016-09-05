--obviously if you are not using this in SN3 you might want a different condition
local debug = SN3Debug
local dbg_print = debug and print or (function() end)

local function GetInputEngine(actionFunction, buttonConv, override)
	return function(event)
		assert(useUpDown or useLeftRight, "what the hell are you trying to do")
		local pn = event.PlayerNumber
		local button = event.GameButton
		if GAMESTATE:IsHumanPlayer(pn) then
			local action = nil
			if buttonConv[button] then
				actionFunction(pn, buttonConv[button])
				return override
			end
			dbg_print("no usable input. button:"..button)
		end
		return true
	end
end

--it probably takes a long time to do all the shit required to load and
--verify a menu definition so once they're good we cache 'em
local savedDefinitions = {}

function MenuNostrum(definitionPath)
	if savedDefinitions[definitionPath] then
		return savedDefinitions[definitionPath]
	end
	local menuDef = dofile_safer(definitionPath)
	if not (type(menuDef) == "table") then
		error("you can't have a non-table")
	end

	--now begins the very long type-checking section
	local choices = menuDef.choices
	assert(type(choices)=="table" and #choices>0,
		"choices must be a non-empty table")
	for idx, choice in ipairs(menuDef.choices) do
		assert(type(choice.name) == "string", "name must be a string")
		assert((choice.onGainFocus==nil) or (type(choice.onGainFocus)=="function"),
			"onGainFocus can either be a function or nothing")
		assert((choice.onLoseFocus==nil) or (type(choice.onLoseFocus)=="function"),
			"onLoseFocus can either be a function or nothing")
		assert(type(choice.onSelect) == "function", "onSelect must be a function")
	end
	--this attempts to determine if there "probably aren't enough mappings"
	local mappings = menuDef.mappings
	assert(type(mappings)=="table" and next(mappings)~=nil,
		"mappings must be a non-empty table")
	do
		local iter = nil
		for i=1, 3 do
			iter = next(mapping, iter)
			if not iter then
				Warn("this MenuNostrum definition probably doesn't have enough mappings: "
					..definitionPath)
				break
			end
		end
	end

	return Def.Actor{
		Name="MenuNostrum";
		OnCommand=function(s) SCREENMAN:GetTopScreen:AddInputCallback()
	}
end
