-- DDRMAX colors
function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#00dcff") end
	if pn == PLAYER_2 then return color("#ff00cf") end
	return color("1,1,1,1")
end

CustomDifficultyColor = {
	Beginner	= color("0.37,0.74,0.88,1"),	-- cyan
	Easy		= color("1,0.996,0,1"),		-- light yellow
	Medium		= color("0.95,0.42,0.48,1"),		-- light pink-red
	Hard		= color("0,0.996,0,1"),		-- light green
	Challenge	= color("0.78,0.4,1,1"),	-- purple blue
	Edit		= color("0.8,0.8,0.8,1"),		-- grey

};

function CustomDifficultyToColor( sCustomDifficulty )
	return CustomDifficultyColor[sCustomDifficulty] or color("#FFFFFF")
end