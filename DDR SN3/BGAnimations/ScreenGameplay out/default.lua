-- normal and rave are handled in normal/default.lua
-- extra stages are in extra1 and extra2.

local t = Def.ActorFrame{
	Def.Actor{ OnCommand=cmd(sleep,5); };
}

if GAMESTATE:IsCourseMode() then
	-- courses always show the normal cleared text
	t[#t+1] = LoadActor("normal")
else
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		-- rave logic is handled in normal
		t[#t+1] = LoadActor("normal")
	else
		-- normal and extra stages
		t[#t+1] = LoadActor("normal")
		t[#t+1] = LoadActor("extra1")
		t[#t+1] = LoadActor("extra2")
	end
end

return t