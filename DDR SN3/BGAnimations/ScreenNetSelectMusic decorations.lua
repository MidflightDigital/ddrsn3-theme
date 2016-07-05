local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFile("Explanation","Explanation")
t[#t+1] = StandardDecorationFromFile("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFile("GrooveRadar","GrooveRadar")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")
-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","Music_In"))..{
		OnCommand=cmd(play);
	};
	LoadActor("ScreenSelectMusic overlay/SNDifficultyList.lua");
};
t[#t+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(draworder,-2;diffuse,color("0,0,0,0.8");setsize,320,80;halign,1;valign,1;x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-30);
	};
	LoadFont("_handelgothic bt 20px")..{
		InitCommand=cmd(diffuse,color("#00ff00");zoom,0.8;x,SCREEN_RIGHT-280;y,SCREEN_CENTER_Y-60);
		OnCommand=cmd(settext,"BPM");
	};
	LoadActor("ScreenSelectMusic overlay/labels")..{
		InitCommand=cmd(x,SCREEN_RIGHT-140;y,SCREEN_CENTER_Y-77);
		OnCommand=cmd(draworder,2;zoom,0.6;diffusealpha,0;addx,400;sleep,0.1;linear,0.52;diffusealpha,0;addx,-400;sleep,0.3;diffusealpha,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,400);
	};
};

--grades
t[#t+1] = Def.ActorFrame {
InitCommand=cmd();
	Def.Quad{
	InitCommand=cmd(zoom,0.25;shadowlength,1;x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y-38;horizalign,center;draworder,2);
	OnCommand=cmd(zoom,0;sleep,1;bouncebegin,0.15;zoom,0.25);
	OffCommand=cmd(bouncebegin,0.15;zoom,0);
		BeginCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_1);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_1);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_1) then
					-- player profile
					profile = PROFILEMAN:GetProfile(PLAYER_1);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					if scores[1] then
						topgrade = scores[1]:GetGrade();
						assert(topgrade);
						if scores[1]:GetScore()>1  then
							if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then
								self:LoadBackground(THEME:GetPathG("GradeDisplayEval","Tier01"));
								self:diffusealpha(1);
							else
								self:LoadBackground(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(topgrade)));
								self:diffusealpha(1);
							end;	
						else
							self:diffusealpha(0);
						end;
					else
						self:diffusealpha(0);
					end;
			else
				self:diffusealpha(0);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	};
--p2
	Def.Quad{
	InitCommand=cmd(zoom,0.25;shadowlength,1;x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y+5;horizalign,center;draworder,2);
	OnCommand=cmd(zoom,0;sleep,1;bouncebegin,0.15;zoom,0.25);
	OffCommand=cmd(bouncebegin,0.15;zoom,0);
		BeginCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_2);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_2);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_2) then
					-- player profile
					profile = PROFILEMAN:GetProfile(PLAYER_2);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					if scores[1] then
						topgrade = scores[1]:GetGrade();
						assert(topgrade);
						if scores[1]:GetScore()>1  then
							if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then
								self:LoadBackground(THEME:GetPathG("GradeDisplayEval","Tier01"));
								self:diffusealpha(1);
							else
								self:LoadBackground(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(topgrade)));
								self:diffusealpha(1);
							end;	
						else
							self:diffusealpha(0);
						end;
					else
						self:diffusealpha(0);
					end;
			else
				self:diffusealpha(0);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
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