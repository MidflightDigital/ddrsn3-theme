local t = Def.ActorFrame{}
t[#t+1] = Def.ActorFrame{
	LoadFont("_handelgothic bt 20px")..{
		InitCommand=function(self)
			self:settext("DanceDanceRevolution SuperNOVA 3")
			:zoom(1.5)
			:Center()
		end;
		OnCommand=cmd(diffusealpha,0;zoom,8;sleep,1;accelerate,1;zoom,1.5;diffusealpha,1;decelerate,2;zoom,2;zoomx,2;diffusealpha,0);
	};
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(diffusealpha,0;sleep,3;addx,300;accelerate,1;diffusealpha,0.8;addx,-300;sleep,2;diffusealpha,0);
	LoadFont("_handelgothic bt 20px")..{
		InitCommand=function(self)
			self:settext("Project Managers\n     HypnoticMarten77\n     Dreamland200\n\nGraphics Team\n     Inorizushi\n     HypnoticMarten77")
			:x(SCREEN_RIGHT-280):halign(0)
			:y(SCREEN_CENTER_Y-160):valign(0)
		end;
	};
};

return t;