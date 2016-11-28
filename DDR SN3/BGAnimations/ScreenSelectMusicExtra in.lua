local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Doorex1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+6;y,SCREEN_CENTER_Y;halign,1);
			OnCommand=cmd(accelerate,0.4;x,SCREEN_CENTER_X-SCREEN_WIDTH);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Doorex2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-16;y,SCREEN_CENTER_Y;halign,0);
			OnCommand=cmd(accelerate,0.4;x,SCREEN_CENTER_X+SCREEN_WIDTH);
		};
	};
};

return t
