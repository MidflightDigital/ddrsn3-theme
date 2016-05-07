return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;linear,0.5;diffusealpha,0.5);
		OffCommand=cmd(sleep,1;linear,0.5;diffusealpha,0);
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/base"))..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;y,SCREEN_TOP+38);
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/Options"))..{
		InitCommand=cmd(x,SCREEN_LEFT+95;halign,0;valign,1;y,SCREEN_TOP+38+5);
	};
	--p1
	LoadActor( "../ScreenPlayerOptions underlay/Back" )..{
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,480);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
	LoadActor( "../ScreenPlayerOptions underlay/Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-300;y,SCREEN_CENTER_Y+150;halign,0);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
	--p2
	LoadActor( "../ScreenPlayerOptions underlay/Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+300;y,SCREEN_CENTER_Y+150;halign,0;zoomx,-1);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
}