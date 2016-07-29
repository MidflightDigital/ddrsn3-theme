function IsStarterMode()
	if GAMESTATE then
		local env = GAMESTATE:Env()
		if GAMESTATE:Env() then
			if not env.StarterMode then
				return false
			end
			return true
		end
	end
	--the question is not yet meaningful if we get here
	return nil
end

--right now this function doesn't do anything useful
function MinimumTNSForCombo()
	return 'TapNoteScore_W3'
end