return Def.ActorFrame {
	Def.ActorFrame{
		Name="DangerP1";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
	HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(cmd(playcommand,"Show"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
					end
				end
			end;
			Def.Quad{
				InitCommand=cmd(visible,false;halign,0;x,SCREEN_LEFT;CenterY;zoomto,SCREEN_WIDTH/2,SCREEN_HEIGHT;diffuseshift;effectcolor1,color("1,0,0,0.8");effectcolor2,color("1,0,0,0");effectclock,"music";fadeleft,1/32;faderight,1/32);
				ShowCommand=cmd(visible,true);
				HideCommand=cmd(visible,false);
			};
		};
	};
	Def.ActorFrame{
		Name="DangerP2";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
	HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(cmd(playcommand,"Show"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
					end
				end
			end;
			Def.Quad{
				InitCommand=cmd(visible,false;halign,1;x,SCREEN_RIGHT;CenterY;zoomto,SCREEN_WIDTH/2,SCREEN_HEIGHT;diffuseshift;effectcolor1,color("1,0,0,0.8");effectcolor2,color("1,0,0,0");effectclock,"music";fadeleft,1/32;faderight,1/32);
				ShowCommand=cmd(visible,true);
				HideCommand=cmd(visible,false);
			};
		};
	};
};