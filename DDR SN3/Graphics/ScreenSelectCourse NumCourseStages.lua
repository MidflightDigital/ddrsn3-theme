return LoadFont("Stagenumber")..{
	BeginCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		local course = GAMESTATE:GetCurrentCourse()
		if course then self:settext(course:GetEstimatedNumStages()) end
	end;
};