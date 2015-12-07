if not GAMESTATE:IsCourseMode() then return Def.ActorFrame{} end; -- short circuit
local course = GAMESTATE:GetCurrentCourse()

local t = Def.ActorFrame{

	-- banner
	Def.Sprite{
		InitCommand=cmd(Center);
		BeginCommand=function(self)
			if course and course:GetBannerPath() then
				self:Load(course:GetBannerPath());
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
			end
			self:setsize(256,80);
		end;
		OnCommand=cmd(scaletoclipped,256,80;CenterX;y,SCREEN_CENTER_Y-130;zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
	};
	
};

return t;
