local PColor = {
P1 = color "#00dcff",
P2 = color "#ff00cf"
};

local xPosPlayer = {
P1 = -158,
P2 = -153
};


local function GetSetCommand(pn)
	return function(self, params)
		local short = ToEnumShortString(pn);
		local SongOrCourse, StepsOrTrail;

		if params and params.Song then
			SongOrCourse = params.Song;
		elseif params and params.Course then
			SongOrCourse = params.Course;
		else 
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
			end;
		end;

		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType();
			local diff = StepsOrTrail:GetDifficulty();
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;
		
			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			local scores = scorelist:GetHighScores();
			local grade;
			if scores[1] then
				grade = scores[1]:GetGrade();
				assert(grade);
				if scores[1]:GetScore()>1 then
					if grade~="Grade_Failed" then
						self:visible(true);
						self:diffuse(color(PColor[short]));
						return;
					end;
				end;
			end;
		end;
		self:visible(false);
	end;
end;

function WheelLight(pn, manual)
	--manual mode means that the WheelLight won't run its own Set command.
	--the only place it's used, something else runs its Set command. 
	local function MsgResponse(s)
		if not manual then
			s:playcommand "Set"
		end
	end

	return Def.Sprite{
		Texture=THEME:GetPathG("MusicWheelItem Song","NormalPart/score");
    	InitCommand=function(s)
			local short = ToEnumShortString(pn)
			s:diffuse(PColor[short])
			if GAMESTATE:GetNumPlayersEnabled() == 2 then
				s:x(xPosPlayer[short]):zoomx(0.5)
			else
				s:x(-155)
			end;
		end;
		CurrentSongChangedMessageCommand=MsgResponse;
		CurrentCourseChangedMessageCommand=MsgResponse;
		CurrentStepsP1ChangedMessageCommand=MsgResponse;
		CurrentTrailP1ChangedMessageCommand=MsgResponse;
		CurrentStepsP2ChangedMessageCommand=MsgResponse;
		CurrentTrailP2ChangedMessageCommand=MsgResponse;
		SetCommand=GetSetCommand(pn);
	}
end