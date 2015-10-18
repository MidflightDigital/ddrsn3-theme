local t = Def.ActorFrame{
	Def.Sprite {
	Texture="bpm_ani 5x4",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_CENTER_X-244):y(SCREEN_CENTER_Y-5)
			self:SetAllStateDelays(0.03)
		end,
		OnCommand=function(self)
			self:diffusealpha(0):sleep(0.6):draworder(50):diffusealpha(1)
		end
	};
};

return t;