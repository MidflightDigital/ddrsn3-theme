local gc = Var("GameCommand");

return Def.ActorFrame {
	Def.ActorFrame{
		LoadActor("title cursor2")..{
			OnCommand=cmd(addx,100;cropright,0.9;sleep,0.2;linear,0.3;cropright,0;faderight,0.2);
			GainFocusCommand=cmd(finishtweening;cropright,1;addx,10;linear,0.166;diffusealpha,0.5;linear,0.2;cropright,0;addx,-10);
			LoseFocusCommand=cmd(finishtweening;linear,0.5;addx,10;diffusealpha,0;addx,-10);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};
	LoadFont("_shared_title") .. {
		Text=gc:GetText(),
		InitCommand=function(self) self:uppercase(true):shadowlength(2):halign(0):zoomy(0.8):diffuse(color("#00ff00")) end,
		OnCommand=function() end,
		GainFocusCommand=function(self) self:finishtweening():diffuse(color("#ffffff")) 
            MESSAGEMAN:Broadcast("TitleSelection", {Choice=gc:GetName()}) end,
		LoseFocusCommand=function(self) self:stopeffect():diffuse(color("0.5,0.5,0.5,1")) end
	};
	Def.ActorFrame{
		LoadActor("title cursor.png")..{
			OnCommand=cmd(addx,100;cropright,0.8;sleep,0.2;linear,0.3;cropright,0;faderight,0.2);
			GainFocusCommand=cmd(finishtweening;cropright,1;addx,-10;linear,0.125;cropright,0;diffusealpha,0.5;addx,10);
			LoseFocusCommand=cmd(finishtweening;linear,0.125;diffusealpha,0);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};
	
};
