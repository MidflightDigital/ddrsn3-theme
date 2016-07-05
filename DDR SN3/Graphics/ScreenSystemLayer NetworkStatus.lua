local netConnected = IsNetConnected();
local loggedOnSMO = IsNetSMOnline();

local t = Def.ActorFrame{
	LoadFont("ScreenSystemLayer Credits") .. {
		InitCommand=cmd(uppercase,true;zoom,1;shadowlength,1;queuecommand,"Begin");
		UpdateTextCommand=cmd(queuecommand,"Begin");
		BeginCommand=function(self)
			-- check network status
			if netConnected then
				self:strokecolor(color("#000000"));
				self:settext(THEME:GetString("ScreenSystemLayer","Network OK") );
			else
				self:strokecolor(color("#000000"));
				self:settext(THEME:GetString("ScreenSystemLayer","Offline") );
			end;
		end;
	};
};

return t;