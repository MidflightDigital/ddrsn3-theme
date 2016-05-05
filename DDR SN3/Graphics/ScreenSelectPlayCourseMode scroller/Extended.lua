return Def.ActorFrame {
	InitCommand=cmd(zoom,1.3);
	
	LoadActor("Choice Extended B")..{
		InitCommand=cmd(x,50;y,-90;zoom,1);
		OnCommand=cmd(diffusealpha,0;linear,0.2;diffusealpha,0);
		LoseFocusCommand=cmd(stoptweening;stopeffect;diffusealpha,0;zoom,1;linear,0.05;diffusealpha,1;zoom,1;x,60);
		GainFocusCommand=cmd(stoptweening;linear,0.05;diffusealpha,0;zoom,1;x,50);
		OffFocusedCommand=cmd(finishtweening;stopeffect;linear,0.2;diffusealpha,0;zoomy,0);
		OffCommand=cmd(finishtweening;stopeffect;linear,0.2;diffusealpha,0;zoomy,0);
	};
	
	LoadActor("Choice Extended A")..{
		InitCommand=cmd(x,50;y,-90;zoom,1);
		OnCommand=cmd(diffusealpha,0;linear,0.2;diffusealpha,1);
		GainFocusCommand=cmd(stoptweening;stopeffect;diffusealpha,0;zoom,1;linear,0.05;diffusealpha,1;zoom,1;x,50);
		LoseFocusCommand=cmd(stoptweening;linear,0.05;diffusealpha,0;zoom,1;x,60);
		OffFocusedCommand=cmd(finishtweening;stopeffect;linear,0.2;diffusealpha,0;zoomy,0);
	};
	
	LoadActor("_selectarrow")..{
		InitCommand=cmd(x,-250;y,-90;zoomx,-1;);
		OnCommand=cmd(diffusealpha,0;linear,0.2;diffusealpha,1);
		GainFocusCommand=cmd(stoptweening;stopeffect;diffusealpha,0;linear,0.05;diffusealpha,1;zoomx,-1;x,-230;bob;effectmagnitude,10,0,0;effectperiod,0.7);
		LoseFocusCommand=cmd(stoptweening;linear,0.05;diffusealpha,0;zoomx,0;x,-250);
		OffFocusedCommand=cmd(finishtweening;stopeffect;linear,0.2;diffusealpha,0;zoom,0);
	};
	LoadActor("_selectarrow")..{
		InitCommand=cmd(x,-300;y,-90;zoomx,-1;);
		OnCommand=cmd(diffusealpha,0;linear,0.2;diffusealpha,1);
		GainFocusCommand=cmd(stoptweening;stopeffect;diffusealpha,0;linear,0.05;diffusealpha,1;zoomx,-1;x,-280;bob;effectmagnitude,10,0,0;effectperiod,0.7);
		LoseFocusCommand=cmd(stoptweening;linear,0.05;diffusealpha,0;zoomx,0;x,-300);
		OffFocusedCommand=cmd(finishtweening;stopeffect;linear,0.2;diffusealpha,0;zoom,0);
	};
};