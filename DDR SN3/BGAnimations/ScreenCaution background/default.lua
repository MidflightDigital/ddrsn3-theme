local t = Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;);
	LoadActor(THEME:GetPathB("","ScreenLogo background/titleback"))..{
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,0.6"));
		OnCommand=cmd(diffusealpha,0.6;sleep,2;linear,0.165;diffusealpha,0);
	};
};

if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
t[#t+1] = Def.ActorFrame {
	LoadActor("home")..{
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
};
else
t[#t+1] = Def.ActorFrame {
	LoadActor("arcade")..{
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,0.165;diffusealpha,0);
	};
};
end

return t;
