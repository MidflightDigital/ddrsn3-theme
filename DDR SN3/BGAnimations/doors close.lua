local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;CenterY;halign,1);
			OnCommand=cmd(decelerate,0.2;x,SCREEN_CENTER_X+51);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;CenterY;halign,0);
			OnCommand=cmd(decelerate,0.2;x,SCREEN_CENTER_X-51);
		};
	};
};

return t
