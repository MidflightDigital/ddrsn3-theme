local t = Def.ActorFrame{
	Def.Quad{
		BeginCommand=function(self)
			if IsSMOnlineLoggedIn('PlayerNumber_P1') then
				self:visible(true):x(SCREEN_CENTER_X*1.5);
			elseif IsSMOnlineLoggedIn('PlayerNumber_P2') then
				self:visible(true):x(SCREEN_CENTER_X*0.5);
			else
				self:visible(false);
			end;
		end;
		InitCommand=function(self)
			self:setsize(280,SCREEN_HEIGHT):CenterY():diffuse(color("0,0,0,0.5"));
		end;
	};
};

return t;