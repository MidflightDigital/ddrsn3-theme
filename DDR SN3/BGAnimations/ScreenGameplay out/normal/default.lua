local t = Def.ActorFrame {
	LoadActor(("../../cleared"))..{
		StartTransitioningCommand=cmd(play);
	};
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	LoadActor(THEME:GetPathB("","doors close"));
};

local clearMessageNormal = LoadActor("cleared")..{
	InitCommand=cmd(Center);
	OnCommand=cmd(diffusealpha,0;zoomy,0;zoomx,4;linear,0.198;diffusealpha,1;zoomy,1;zoomx,1;sleep,2.604;linear,0.132;zoomy,0;zoomx,4;diffusealpha,0);
};
if GAMESTATE:IsCourseMode() then
	t[#t+1] = clearMessageNormal
else
	-- normal mode; hide if extra stage achieved
	t[#t+1] = clearMessageNormal..{
		StartTransitioningCommand=cmd(visible,GAMESTATE:GetEarnedExtraStage() == 'EarnedExtraStage_No');
	}
end

return t