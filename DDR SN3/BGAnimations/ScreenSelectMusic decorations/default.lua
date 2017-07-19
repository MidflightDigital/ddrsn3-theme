local t = LoadFallbackB();
local extra = Var "LoadingScreen" == "ScreenSelectMusicExtra"
local normal = Var "LoadingScreen" == "ScreenSelectMusic"
SOUND:DimMusic(1,math.huge)

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
if not extra then
	t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")
end
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")

if normal or extra then
if ThemePrefs.Get("XDifficultyList") == "SN Style" then
	t[#t+1] = Def.ActorFrame{
		LoadActor("difficultylist")..{
			InitCommand=cmd(x,DiffBGPosX();y,SCREEN_CENTER_Y+141;visible,GAMESTATE:IsCourseMode() == false);
			OnCommand=cmd(draworder,1;cropright,1;sleep,0.264;sleep,0.6;linear,0.4;cropright,0);
			OffCommand=cmd(sleep,0.033;accelerate,0.363;x,-237);
		};
		LoadActor("SNDifficultyList.lua");
	};
elseif ThemePrefs.Get("XDifficultyList") == "X Style" then
	t[#t+1] = Def.ActorFrame{
		LoadActor("Xdiffback")..{
			InitCommand=cmd(x,DiffBGPosX();y,SCREEN_CENTER_Y+141;visible,GAMESTATE:IsCourseMode() == false);
			OnCommand=cmd(draworder,1;cropright,1;sleep,0.264;sleep,0.6;linear,0.4;cropright,0);
			OffCommand=cmd(sleep,0.033;accelerate,0.363;x,-237);
		};
		LoadActor("XDifficultyList.lua");
	};
end;
end;

if normal then

if ThemePrefs.Get("LightMode") == false then
	t[#t+1] = Def.ActorFrame{
		LoadActor("gauge back")..{
			InitCommand=cmd(x,BPMMeterPosX();y,SCREEN_CENTER_Y-140);
			OnCommand=cmd(addx,-500;sleep,0.264;decelerate,0.52;addx,500;sleep,0.1;linear,0);
		};
	};
end;

t[#t+1] = Def.ActorFrame{
	LoadActor("bpmmeter.lua");
};
-------------------------------------------------------------------------------------------------------------------
-- Groove Radars
-------------------------------------------------------------------------------------------------------------------
t[#t+1] = Def.ActorFrame{
	Name = "Player 1";
	OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,0.75);
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
		PLAYER_1, 60, color("1,1,1,0.25"),
		{ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1},
		"accelerate", .25)
};
t[#t+1] = Def.ActorFrame{
	Name = "Player 2";
	OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
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
		PLAYER_2, 60, color("1,1,1,0.25"),
		{ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2},
		"accelerate", .25)
};


t[#t+1] = Def.ActorFrame{
	LoadActor("radar lights (doubleres)")..{
		InitCommand=cmd(xy,RadarPosX(),SCREEN_CENTER_Y+7;diffuseshift;effectcolor1,color("1,1,1,0.75");effectcolor2,color("1,1,1,0.25");effectclock,'beatnooffset');
		OnCommand=cmd(zoomy,0;addx,-400;sleep,0.264;linear,0.2;zoomy,0.3;addx,400;linear,0.2;zoomy,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
	LoadActor("labels")..{
		InitCommand=cmd(x,RadarPosX();y,SCREEN_CENTER_Y+7);
		OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
};
end

-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","Music_In"))..{
		OnCommand=cmd(play);
	};
};

--new song--
if not GAMESTATE:IsCourseMode() then
	t[#t+1] = StandardDecorationFromFileOptional("NewSong","NewSong") .. {
		InitCommand=cmd(playcommand,"Set");
		BeginCommand=cmd(playcommand,"Set");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
	-- 		local pTargetProfile;
			local sSong;
			-- Start!
			if GAMESTATE:GetCurrentSong() then
				if PROFILEMAN:IsSongNew(GAMESTATE:GetCurrentSong()) then
					self:playcommand("Show");
				else
					self:playcommand("Hide");
				end
			else
				self:playcommand("Hide");
			end
		end;
	};
end;

return t
