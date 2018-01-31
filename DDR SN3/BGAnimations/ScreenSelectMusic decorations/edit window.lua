local player = ({...})[1]
local short_player = ToEnumShortString(player)

local t =  Def.ActorFrame{
	LoadActor("editwindow back")
}
t["CurrentSteps"..short_player.."ChangedMessageCommand"] = function(s, param)
	local steps = GAMESTATE:GetCurrentSteps(player)
	if steps and steps:GetDifficulty() == 'Difficulty_Edit' then
		s:visible(true)
	else
		s:visible(false)
	end
end

return t