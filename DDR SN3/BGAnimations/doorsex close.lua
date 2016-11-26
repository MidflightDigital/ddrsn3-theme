local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Doorex1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;CenterY;halign,1;zoom,1.1);
			OnCommand=cmd(decelerate,0.4;x,SCREEN_CENTER_X+10;sleep,4);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","Doorex2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;CenterY;halign,0;zoom,1.1);
			OnCommand=cmd(decelerate,0.4;x,SCREEN_CENTER_X-12;sleep,4);
		};
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_siren"))..{
		OnCommand=cmd(playcommand,"Play");
		PlayCommand=cmd(sleep,0.8;play);
	};
};

return t
