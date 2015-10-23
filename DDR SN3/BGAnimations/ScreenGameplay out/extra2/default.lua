-- extra stage 2
-- todo: stars, after I figure out if it's ok

return Def.ActorFrame{
	StartTransitioningCommand=cmd(visible,GAMESTATE:GetEarnedExtraStage() == 'EarnedExtraStage_Extra2');

	LoadActor("_extra")..{
		StartTransitioningCommand=function(self)
			if GAMESTATE:GetEarnedExtraStage() == 'EarnedExtraStage_Extra2' then
				self:play()
			end
		end;
	};

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,0"));
		OnCommand=cmd(sleep,1;linear,0.3;diffusealpha,1);
	};

	LoadActor("extra2")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,4;);
		OnCommand=cmd(sleep,0.8;accelerate,0.4;diffusealpha,0.6;zoom,0.77;linear,0.05;zoom,1;linear,0.05;zoom,1.0;sleep,2;linear,0.3;diffusealpha,0);
	};
	LoadActor("extra2")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,4;);
		OnCommand=cmd(sleep,0.85;accelerate,0.4;diffusealpha,0.6;zoom,0.77;linear,0.05;zoom,1;linear,0.05;zoom,1.0;sleep,2;linear,0.3;diffusealpha,0);
	};
};