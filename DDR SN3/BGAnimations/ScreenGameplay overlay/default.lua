local t = Def.ActorFrame{};
-- Full combo
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("FullCombo", pn) .. {
	};
end;



--battleshit
if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
t[#t+1] = Def.ActorFrame{
	LoadActor("p1 over")..{
		InitCommand=cmd(y,SCREEN_TOP+78;x,SCREEN_CENTER_X-2);
	};
	LoadActor("p2 over")..{
		InitCommand=cmd(y,SCREEN_TOP+78;x,SCREEN_CENTER_X+2);
	};
};
end;

return t;