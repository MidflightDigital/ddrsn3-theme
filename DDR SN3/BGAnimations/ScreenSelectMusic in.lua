local t = Def.ActorFrame {};
if GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2() then
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathB("","Extradoor1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y;zoom,1.01;halign,1);
		OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X-SCREEN_WIDTH);
	};
	LoadActor(THEME:GetPathB("","Extradoor2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-50;y,SCREEN_CENTER_Y;zoom,1.01;halign,0);
		OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X+SCREEN_WIDTH);
	};
};
end

return t