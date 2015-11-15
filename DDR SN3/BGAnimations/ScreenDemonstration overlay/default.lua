return Def.ActorFrame{
	LoadActor("demglow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-195;y,SCREEN_TOP+18;zoomx,1280);
		OnCommand=cmd(diffuseshift;effectcolor1,color("#000000");effectcolor2,color("#a2e85f");effectperiod,2.2);
	};
	LoadActor("demup")..{
		InitCommand=cmd(x,SCREEN_LEFT;;halign,0;valign,0);
	};
	LoadActor("demdown")..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM;halign,1;valign,1);
	};
};