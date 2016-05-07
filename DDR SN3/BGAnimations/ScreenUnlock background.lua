local TextEntrySettings = {
	-- ScreenMessage to send on pop (optional, "SM_None" if omitted)
	--SendOnPop = "",

	-- The question to display
	Question = "Enter your unlock code:",
	
	-- Initial answer text
	InitialAnswer = "",
	
	-- Maximum amount of characters
	MaxInputLength = 30,
	
	-- Validation function; function(answer, errorOut), must return boolean, string.
	Validate = nil,
	
	-- On OK; function(answer)
	OnOK = function(answer)
		UnlockSomeStuffMaybe(answer)
	end,
	
	-- On Cancel; function()
	OnCancel = nil,
	
	-- Validate appending a character; function(answer,append), must return boolean
	ValidateAppend = nil,
	
	-- Format answer for display; function(answer), must return string
	FormatAnswerForDisplay = nil,
}


local t =  Def.ActorFrame{	
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():Load(TextEntrySettings)
	end
}

return t