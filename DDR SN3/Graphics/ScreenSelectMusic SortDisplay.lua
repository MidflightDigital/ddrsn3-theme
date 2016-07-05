local t = Def.ActorFrame {
	Def.Sprite{
		BeginCommand=cmd(playcommand,"SetGraphic");
		SetGraphicCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			if so ~= nil then
				local sort = ToEnumShortString(so)
				self:Load(THEME:GetPathG("","_sort/_"..sort));
			end;
		end;
		SortOrderChangedMessageCommand=function(self)
			self:accelerate(0.18)
			self:addy(-28)
			self:queuecommand("SetGraphic");
			self:sleep(0.2)
			self:decelerate(0.18)
			self:addy(28)
		end;
	};
};

return t;