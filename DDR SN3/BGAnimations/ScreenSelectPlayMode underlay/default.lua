
local t = Def.ActorFrame{
	LoadActor("rail")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-240;CenterY;croptop,1;cropbottom,1);
		OnCommand=cmd(linear,1;croptop,0;cropbottom,0);
		OffCommand=cmd(linear,1;croptop,1;cropbottom,1);
	};
};

return t;