local t = LoadFallbackB();

if not GAMESTATE:IsCourseMode() then
	local function GenerateModIconRow(pn)
		local MetricsName = "ModIcons" .. ToEnumShortString(pn);
		return Def.ActorFrame {
			InitCommand=function(self) self:name(MetricsName); ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); end;
			LoadActor( THEME:GetPathG("OptionIcon","Player") )..{
				InitCommand=cmd(pause;halign,0;x,-19);
				BeginCommand=function(self)
					self:setstate( pn == PLAYER_1 and 0 or 1 );
				end;
			};
			
			Def.ModIconRow {
				InitCommand=cmd(Load,"OptionRowPlayer"..ToEnumShortString(pn),pn;x,341;y,1;);
			};
		};
	end;

	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if ShowStandardDecoration("ModIcons") then
			t[#t+1] = GenerateModIconRow(pn);
		end
	end;
end;

-- difficulty icons
if ShowStandardDecoration("DifficultyIcons") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local diffIcon = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyIcon"), pn)
		t[#t+1] = StandardDecorationFromTable( "DifficultyIcon" .. ToEnumShortString(pn), diffIcon );
	end
end

-- other items (balloons, etc.)

t[#t+1] = LoadActor("../slash")..{
	InitCommand=cmd(draworder,99;x,SCREEN_RIGHT-103;y,SCREEN_CENTER_Y-220);
}

return t