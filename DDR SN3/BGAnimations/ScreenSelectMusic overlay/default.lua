local t = Def.ActorFrame{}

if SN3Debug and (not GAMESTATE:IsCourseMode()) then
	local yPositions = {
		PlayerNumber_P1 = SCREEN_TOP+100,
		PlayerNumber_P2 = SCREEN_BOTTOM-100
	}
	for _,pn in pairs(PlayerNumber) do
		t[#t+1] = Def.ActorFrame{InitCommand=function(s) s:x(WheelPosX()):y(yPositions[pn]) end,
			LoadActor("edit window", pn)}
	end
end

return t