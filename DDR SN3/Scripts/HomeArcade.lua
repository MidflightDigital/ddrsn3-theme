function StyleChoices()
	local choices = "1,2,3"
	local coinMode = GAMESTATE:GetCoinMode()
	if coinMode == 'CoinMode_Home' then choices = choices .. "" end
	return choices
end

function ModeChoices()
	local choices = "1,2,3,4,5,6"
	local coinMode = GAMESTATE:GetCoinMode()
	if coinMode == 'CoinMode_Home' then choices = choices .. "" end
	return choices
end
