-- normal and rave are handled in normal/default.lua
-- extra stages are in extra1 and extra2.

local t = Def.ActorFrame{
	Def.Actor{ OnCommand=cmd(sleep,5); };
}

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
	-- rave logic is handled in normal
	t[#t+1] = LoadActor("rave")
else
	-- normal and extra stages
	t[#t+1] = LoadActor("normal")
end;

return t;