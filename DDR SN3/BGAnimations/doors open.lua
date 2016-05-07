local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y;zoom,1.01;halign,1);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X-SCREEN_WIDTH);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-50;y,SCREEN_CENTER_Y;zoom,1.01;halign,0);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X+SCREEN_WIDTH);
		};
	};
};

return t