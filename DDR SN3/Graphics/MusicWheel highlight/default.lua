local t = Def.ActorFrame {
	LoadActor("Backing");
--P1 Light--
	Def.Sprite{
    Texture=THEME:GetPathG("MusicWheelItem Song","NormalPart/score");
    InitCommand=function(s)
		if GAMESTATE:GetNumPlayersEnabled() == 2 then
			s:x(-158):zoomx(0.5):diffuse(color("#00f0ff"))
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			s:x(-155):diffuse(color("#00f0ff"))
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
    SetCommand=function(self,params)
	local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_1);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_1);
			end;
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
		local grade;
		if scores[1] then
			grade = scores[1]:GetGrade();
			assert(grade);
			if scores[1]:GetScore()>1 then
				if grade=="Grade_Tier07" then
					self:visible(true);
					self:diffuse(color("#ff0000"));
					self:draworder(1);
				else
					self:visible(true);
					self:diffuse(color("#00f0ff"));
				end;
			else
				self:visible(false);
			end;
		else
			self:visible(false);
		end;
	else
		self:visible(false);
	end;
	end;
	};
--P2 Light--
	Def.Sprite{
    Texture=THEME:GetPathG("MusicWheelItem Song","NormalPart/score");
    InitCommand=function(s)
		if GAMESTATE:GetNumPlayersEnabled() == 2 then
			s:x(-153):zoomx(0.5):diffuse(color("#ff00cf"))
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			s:x(-155):diffuse(color("#ff00cf"))
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
    SetCommand=function(self,params)
	local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_2);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_2);
			end;
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
		local grade;
		if scores[1] then
			grade = scores[1]:GetGrade();
			assert(grade);
			if scores[1]:GetScore()>1 then
				if grade=="Grade_Tier07" then
					self:visible(true);
					self:diffuse(color("#ff0000"));
					self:draworder(1);
				else
					self:visible(true);
					self:diffuse(color("#ff00cf"));
				end;
			else
				self:visible(false);
			end;
		else
			self:visible(false);
		end;
	else
		self:visible(false);
	end;
	end;
	};
};
if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
t[#t+1] = Def.ActorFrame {
	LoadActor("frame")..{
		BeginCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:croptop(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropbottom(0.5)
			end
		end;
	};
};
end

return t;