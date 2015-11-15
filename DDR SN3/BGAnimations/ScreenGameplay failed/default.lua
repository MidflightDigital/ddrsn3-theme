local t = Def.ActorFrame {
	LoadActor(("../failed"))..{
		StartTransitioningCommand=cmd(play);
	};
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;CenterY;zoom,1.01;halign,1);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X+50);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Door2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;CenterY;zoom,1.01;halign,0);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X-50);
		};
	};
	Def.ActorFrame{
		LoadActor("failed")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;zoomy,0;zoomx,4;linear,0.198;diffusealpha,1;zoomy,1;zoomx,1;sleep,2.604;linear,0.132;zoomy,0;zoomx,4;diffusealpha,0);
		};
	};
};

return t