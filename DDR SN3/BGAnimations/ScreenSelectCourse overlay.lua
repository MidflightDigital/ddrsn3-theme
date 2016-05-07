local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","_footer/confirm"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-32);
		OnCommand=cmd(halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(decelerate,0.2;addy,54);
	};
	LoadActor(THEME:GetPathG("","_footer/select"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-32;halign,1);
		OnCommand=cmd(addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(decelerate,0.2;addy,54);
	};
	LoadActor(THEME:GetPathG("","_footer/difficulty"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-115;y,SCREEN_BOTTOM-12;halign,1);
		OnCommand=cmd(addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(decelerate,0.2;addy,54);
	};
};
return t