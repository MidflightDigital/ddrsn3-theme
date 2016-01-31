local t = Def.ActorFrame{
	LoadFont("ScreenSystemLayer Credits") .. {
		InitCommand=cmd(uppercase,true;zoom,1;shadowlength,1;queuecommand,"Begin";);
		BeginCommand=function(self)
			-- check network status
			if IsNetSMOnline() then
				self:settext( THEME:GetString( "ScreenSystemLayer", "Network OK" ) );
			else
				self:settext( THEME:GetString( "ScreenSystemLayer", "Offline" ) );
			end;
			self:sleep(1):queuecommand "Begin"
		end;
	};
};

return t;