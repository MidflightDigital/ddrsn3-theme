local t = Def.ActorFrame{
	LoadActor("SNDifficultyList.lua");
	LoadActor("bpmmeter.lua");
	LoadActor("labels")..{
		InitCommand=cmd(x,SCREEN_LEFT+201;y,SCREEN_CENTER_Y+7);
		OnCommand=cmd(draworder,2;diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
	Def.Sprite {
	Texture="WheelEffect 5x4",
		InitCommand=function(self)
			self:draworder(100):x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y-16.5)
			self:SetAllStateDelays(0.04)
		end,
		OnCommand=function(self)
			self:addx(380):sleep(0.264):sleep(0.558):decelerate(0.231):addx(-380)
		end,
		OffCommand=function(self)
			self:accelerate(0.396):addx(380)
		end
	};
	LoadActor(THEME:GetPathG("","_footer/confirm"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-32);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/select"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-32;halign,1);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/difficulty"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-115;y,SCREEN_BOTTOM-12;halign,1);
		OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor(THEME:GetPathG("","_footer/sort"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-125;y,SCREEN_BOTTOM-32;halign,1);
		OnCommand=cmd(diffuseblink;effectcolor1,1,1,1,1;effectcolor2,0,0,0,0;effectperiod,2;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
		OffCommand=cmd(linear,0.4;addx,236;linear,0;addy,999);
	};
	LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(player,PLAYER_1;x,SCREEN_LEFT+109;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+201);
		end;
	};
	LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(player,PLAYER_2;x,SCREEN_LEFT+218;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+201);
		end;
	};
};

--grades
t[#t+1] = Def.ActorFrame {
InitCommand=cmd();
	Def.Quad{
	InitCommand=cmd(zoom,0.25;shadowlength,1;x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y-38;horizalign,center;draworder,2);
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
	InitCommand=cmd(zoom,0.25;shadowlength,1;x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y+38;horizalign,center;draworder,2);
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

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
		InitCommand=cmd(Center);
		SetMessageCommand=function(self,params)
		local song = params.Song;
		local pssp1 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P1")
		local staw1 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P1"):GetStageAward();
		local pssp2 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P2")
			if song then
				if not PROFILEMAN:IsSongNew(params.Song) then
				self:Load(THEME:GetPathG("MusicWheelItem Song","NormalPart/score"));
				self:diffusealpha(1);
				self:draworder(2);
				else
				self:diffusealpha(0);
				end;
			end;
		end;
	};
};

return t;