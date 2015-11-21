local t = Def.ActorFrame {
	LoadActor(("../failed"))..{
		StartTransitioningCommand=cmd(play);
	};
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	LoadActor(THEME:GetPathB("","doors close"));
	Def.ActorFrame{
		LoadActor("failed")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;zoomy,0;zoomx,4;linear,0.198;diffusealpha,1;zoomy,1;zoomx,1;sleep,2.604;linear,0.132;zoomy,0;zoomx,4;diffusealpha,0);
		};
	};
};

return t