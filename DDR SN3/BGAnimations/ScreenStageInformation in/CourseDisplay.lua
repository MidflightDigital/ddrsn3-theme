if not GAMESTATE:IsCourseMode() then return Def.ActorFrame{} end; -- short circuit
local course = GAMESTATE:GetCurrentCourse()

local t = Def.ActorFrame{

	-- banner
	Def.Sprite{
		InitCommand=cmd(Center);
		BeginCommand=function(self)
			if course then
				self:LoadBackground(course:GetBannerPath());
				self:setsize(256,80);
			else
				-- default to the Banner of the first song in the course
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,80);
			end
		end;
		OnCommand=cmd(scaletoclipped,256,80;CenterX;y,SCREEN_CENTER_Y-130;zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
	};
	
};

return t;