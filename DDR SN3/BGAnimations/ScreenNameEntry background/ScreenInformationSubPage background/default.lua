local index = tonumber(getenv("InfoIndex"))

local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_TOP+12;valign,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("#083918"));
	};
	LoadActor("_bg")..{ InitCommand=cmd(Center); };
	LoadActor("_frame")..{ InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+4); };
	LoadFont("_2070polyester square 24px")..{
		Text="information";
		InitCommand=cmd(x,SCREEN_CENTER_X-263;y,SCREEN_CENTER_Y-126;halign,0;zoom,0.45;diffuse,color("#305018"));
	};

	-- arrows
	LoadActor("_left")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-286;y,SCREEN_CENTER_Y+142);
		OnCommand=cmd(visible,index>1);
	};
	LoadActor("_right")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+286;y,SCREEN_CENTER_Y+142);
		OnCommand=cmd(visible,index<#infoPages);
	};
};

return t;