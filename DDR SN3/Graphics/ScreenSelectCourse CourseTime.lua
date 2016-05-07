return LoadFont("time")..{
	BeginCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		local course = GAMESTATE:GetCurrentCourse()
		if course then
			local style = GAMESTATE:GetCurrentStyle()
			local stepsType = style:GetStepsType()
			local courseLen = course:GetTotalSeconds(stepsType)
			if courseLen then
				self:settext( SecondsToMMSSMsMs(courseLen) )
			else
				self:settext( "xx:xx.xx" )
			end
		end
	end;
};