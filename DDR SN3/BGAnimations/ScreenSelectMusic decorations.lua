local t = LoadFallbackB();

if not GAMESTATE:IsCourseMode() then
	local function GenerateModIconRow(pn)
		local MetricsName = "ModIcons" .. ToEnumShortString(pn);
		return Def.ActorFrame {
			InitCommand=function(self) self:name(MetricsName); ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); end;
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
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(draworder,99;diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,0.75);
	CurrentSongChangedMessageCommand=function(self)
		local Song=GAMESTATE:GetCurrentSong()
			if not Song then
				self:diffusealpha(0)
			else
				self:diffusealpha(0.75)
			end;
		end;
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P1_radar", RadarPosX(), SCREEN_CENTER_Y+16,
		PLAYER_1, 60, color("1,1,1,0.75"),
		{ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1},
		"accelerate", .25)
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(draworder,99;diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
	CurrentSongChangedMessageCommand=function(self)
		local Song=GAMESTATE:GetCurrentSong()
			if not Song then
				self:diffusealpha(0)
			else
				self:diffusealpha(0.75)
			end;
		end;
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P2_radar", RadarPosX(), SCREEN_CENTER_Y+16,
		PLAYER_2, 60, color("1,1,1,0.75"),
		{ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2},
		"accelerate", .25)
};
-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","Music_In"))..{
		OnCommand=cmd(play);
	};
};

return t
