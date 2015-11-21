return Def.ActorFrame{
	LoadActor("frame")..{
		BeginCommand=cmd(playcommand,"IsCourseMode");
		IsCourseModeCommand=function(self,param)
			if GAMESTATE:IsCourseMode() == true then
				self:cropbottom(0.5)
			end
		end;
	};
}