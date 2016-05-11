--local netConnected = IsNetConnected();
--local loggedOnSMO = IsNetSMOnline();

local t = Def.ActorFrame{
	LoadFont("ScreenSystemLayer Credits") .. {
		InitCommand=cmd(uppercase,true;zoom,1;shadowlength,1);
		BeginCommand=function(self)
			-- check network status
			if IsNetSMOnline() then
				self:strokecolor(color("#000000"));
				self:settext( Screen.String("Network OK") );
			else
				self:strokecolor(color("#000000"));
				self:settext( Screen.String("Offline") );
			end;
			self:sleep(1):queuecommand("Begin")
		end;
	};
};

if false then
	t[#t+1] = LoadFont("_network") .. {
		InitCommand=cmd(y,16;horizalign,left;zoom,0.5875;shadowlength,1;diffuse,color("0.72,0.89,1,1"));
		BeginCommand=function(self)
			self:settext( string.format(Screen.String("Connected to %s"), GetServerName()) );
		end;
	};
end;

return t;