local gc = Var "GameCommand";
local colors = {
	Easy		= color("#00ff00"),
	Normal		= color("#feee00"),
	Hard		= color("#feee00"),
	Rave		= color("#db93ff"),
	Nonstop		= color("#00ffff"),
	Oni			= color("#d70b8c"),
	Endless		= color("#b4c3d2"),
};

local icon_color = ModeIconColors[gc:GetName()];

local string_name = gc:GetText();
local string_expl = THEME:GetString(Var "LoadingScreen", gc:GetName() .. "Explanation");
local t = Def.ActorFrame {};

-- Background!
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("ScreenSelectPlayMode","BackgroundFrame")) .. {
		GainFocusCommand=cmd(visible,true);
		LoseFocusCommand=cmd(visible,false);
	};
};

-- Emblem Frame
t[#t+1] = Def.ActorFrame {
	FOV=90;
	InitCommand=cmd(x,-192;zoom,0.9);
	-- Main Emblem
	LoadActor( gc:GetName() ) .. {
		InitCommand=cmd(diffusealpha,0;zoom,0.75);
		GainFocusCommand=cmd(finishtweening;stopeffect;diffusealpha,1;zoom,1;glow,Color("White");decelerate,0.5;glow,Color("Invisible");pulse;effecttiming,0.75,0.125,0.125,0.75;effectmagnitude,0.95,1,1;);
		LoseFocusCommand=cmd(finishtweening;stopeffect;smooth,0.4;diffusealpha,0;zoom,0.75;glow,Color("Invisible"));
		OffFocusedCommand=cmd(finishtweening;stopeffect;glow,icon_color;decelerate,0.5;rotationy,360;glow,Color("Invisible"));
	};
};

-- Text Frame
t[#t+1] = Def.ActorFrame {
	LoadFont("Common Normal") .. {
		Text=string_expl;
		InitCommand=cmd(x,-100;y,-45;shadowlength,1;diffusealpha,0;zoom,0.8;halign,0);
		GainFocusCommand=cmd(finishtweening;x,0;decelerate,0.45;diffusealpha,1;x,-100);
		LoseFocusCommand=cmd(finishtweening;x,-100;accelerate,0.4;diffusealpha,0;x,-100-15;diffusealpha,0);
	};
};

t.GainFocusCommand=cmd(finishtweening;visible,true;rotationx,90;decelerate,0.25;rotationx,0);
t.LoseFocusCommand=cmd(finishtweening;visible,false;zoom,1);

return t