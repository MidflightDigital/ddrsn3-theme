local counter = 0;
local t = Def.ActorFrame{
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:zoom(1);
	end;
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("ScreenWithMenuElements","background/default.lua"));
		LoadActor("ScreenLogo background/ddrsn_logo.png")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9);
		};
		LoadActor("ScreenLogo background/ddrsn_logo.png")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9);
			OnCommand=cmd(sleep,2;diffusealpha,0.4;zoom,0.9;linear,2;zoom,1;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,3.5;queuecommand,"On");
		};
		LoadActor("ScreenLogo background/ddrsn_konami")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-2;y,SCREEN_BOTTOM-40);
		};
		LoadActor(THEME:GetPathG("","ScreenTitleJoin Messages/_free play"))..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+120);
			OnCommand=cmd(diffuseshift;effectcolor1,color("0.5,0.5,0.5,1");effectcolor2,color("1,1,1,1");effectperiod,1.5);
		};
	};
};

return t;