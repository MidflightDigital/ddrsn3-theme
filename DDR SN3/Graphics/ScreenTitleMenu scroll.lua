local gc = Var("GameCommand");

return Def.ActorFrame {
	Def.ActorFrame{
		LoadActor("title cursor2")..{
			OnCommand=cmd(halign,0;addx,-114;cropright,0.9;sleep,0.2;linear,0.3;cropright,0;faderight,0.2);
			GainFocusCommand=cmd(stoptweening;cropright,1;addx,10;linear,0.125;diffusealpha,0.5;cropright,0;addx,-10);
			LoseFocusCommand=cmd(stoptweening;linear,0.125;addx,10;diffusealpha,0;);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};
	LoadFont("_shared_title") .. {
		Text=gc:GetText(),
		InitCommand=function(self) self:uppercase(true):shadowlength(2) end,
		OnCommand=function() end,
		GainFocusCommand=function(self) self:stoptweening():diffuse(color("#ffffff")) 
            MESSAGEMAN:Broadcast("TitleSelection", {Choice=gc:GetName()}) end,
		LoseFocusCommand=function(self) self:stopeffect():diffuse(color("#33CC33")) end
	};
	Def.ActorFrame{
		LoadActor("title cursor.png")..{
			OnCommand=cmd(cropright,0.9;addx,114;sleep,0.2;linear,0.3;addx,-114;cropright,0;faderight,0.2);
			GainFocusCommand=cmd(stoptweening;cropright,1;addx,-10;linear,0.125;cropright,0;diffusealpha,0.5;addx,10);
			LoseFocusCommand=cmd(stoptweening;linear,0.125;diffusealpha,0);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};
	
};
