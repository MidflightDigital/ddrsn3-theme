local function CreditsText( pn )
	local text = LoadFont(Var "LoadingScreen","credits") .. {
		InitCommand=function(self)
			self:name("Credits" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
			self:settext(str);
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end

			self:visible( bShow );
		end
	};
	return text;
end;

local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	--Network
t[#t+1] = StandardDecorationFromFileOptional("NetworkStatus","NetworkStatus");
	-- Credits
t[#t+1] = Def.ActorFrame {
 	CreditsText( PLAYER_1 );
};
	-- Text
t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("0,0,0,1"));
		OnCommand=cmd(finishtweening;diffusealpha,0.85;);
		OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};
	Def.BitmapText{
		Font="_network";
		Name="Text";
		InitCommand=cmd(horizalign,left;vertalign,top;y,SCREEN_TOP+10;x,SCREEN_LEFT+10;maxwidth,SCREEN_WIDTH;shadowlength,1;diffusealpha,0;);
		OnCommand=cmd(finishtweening;diffusealpha,1;zoom,0.5);
		OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = cmd(finishtweening);
};

return t;
