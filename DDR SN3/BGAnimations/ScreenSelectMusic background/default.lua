return Def.ActorFrame{

	LoadActor( "../ScreenWithMenuElements background" );
	
	
	
	
	LoadActor( "../CourseModeBG" )..{
		InitCommand=cmd();
		OnCommand=function(self)
			if (GAMESTATE:IsCourseMode()) then
				self:zoom(1);
			else
				self:zoom(0);
			end
		end;
		
	};
	
	LoadActor( "../ExModeBG" )..{
		InitCommand=cmd();
		OnCommand=function(self)
			
			if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2()  then
				(cmd(zoom,1))(self);
			else
				(cmd(zoom,0))(self);
			end;
		end;
	};
	
};