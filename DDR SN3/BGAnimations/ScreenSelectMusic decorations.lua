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
				InitCommand=cmd(Load,"ModIconRowSelectMusic"..ToEnumShortString(pn),pn;x,341;y,1;);
			};
		};
	end;

	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if ShowStandardDecoration("ModIcons") then
			t[#t+1] = GenerateModIconRow(pn);
		end
	end;
end;

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")

-- difficulty icons
if ShowStandardDecoration("DifficultyIcons") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local diffFrame = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyFrame"), pn)
		t[#t+1] = StandardDecorationFromTable( "DifficultyFrame" .. ToEnumShortString(pn), diffFrame );

		local diffIcon = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyIcon"), pn)
		t[#t+1] = StandardDecorationFromTable( "DifficultyIcon" .. ToEnumShortString(pn), diffIcon );
	end
end

t[#t+1] = StandardDecorationFromFileOptional("GrooveRadar","GrooveRadar")

-- StepsDisplay
local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState(player);
	end

	local name = "StepsDisplaySelMusic";

	local sd = Def.StepsDisplay {
		InitCommand=cmd(Load,name..ToEnumShortString(pn),GAMESTATE:GetPlayerState(pn););
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				-- hacky hack 1: set all feet to nothing!
				self:GetChild("Ticks"):settext("0000000000");
				-- hacky hack 2: diffuse to beginner
				self:GetChild("Ticks"):diffuse(CustomDifficultyToColor("Beginner"))
			end
		end;
	};

	if pn == PLAYER_1 then
		sd.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		sd.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		sd.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		sd.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return sd;
end

if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		-- frame
		local meterFrame = LoadActor(THEME:GetPathG(Var "LoadingScreen", "MeterFrame"), pn)
		t[#t+1] = StandardDecorationFromTable( "MeterFrame" .. ToEnumShortString(pn), meterFrame );

		-- stepsdisplay
		local MetricsName = "StepsDisplay" .. PlayerNumberToString(pn);
		t[#t+1] = StepsDisplay(pn) .. {
			InitCommand=function(self)
				self:player(pn);
				self:name(MetricsName);
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
			end;
		};
	end
end

-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)

return t