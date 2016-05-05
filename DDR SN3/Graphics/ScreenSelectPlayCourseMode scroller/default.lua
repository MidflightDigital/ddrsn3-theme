local gc = Var("GameCommand");
local t = Def.ActorFrame {};
-- Emblem Frame
t[#t+1] = Def.ActorFrame {
	FOV=90;
	InitCommand=cmd(x,0;zoom,1);
	
	-- Main Shadow
	LoadActor( gc:GetName()) .. {
		
	};
	-- Main Emblem
	LoadActor( gc:GetName() ) .. {
		
	};
};
-- Text Frame
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,0;y,0);
	Def.Quad {
		InitCommand=cmd(cropleft,0.5;cropright,0.5;zoomto,1000,2;diffuse,Color("Black"));
		OnCommand=cmd(linear,0.2;cropleft,0;cropright,0);
		OffFocusCommand=cmd(stoptweening;linear,0.2;cropleft,0.5;cropright,0.5;);
	};
};
return t