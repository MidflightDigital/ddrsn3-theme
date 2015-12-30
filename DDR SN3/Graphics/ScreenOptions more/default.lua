return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(player,PLAYER_1;x,-230;y,77.5);
		LoadActor("1P_OK")..{
			InitCommand=cmd(diffusealpha,0;zoomy,0);
		--	ExitSelectedP1Command=cmd(stoptweening;bob;effectmagnitude,0,2,0;effectperiod,1;bounceend,0.2;diffusealpha,1;zoom,1);
		--	ExitUnselectedP1Command=cmd(stoptweening;diffusealpha,0;zoomy,0);
			ExitSelectedP1Command=function(self)
				setenv("PlayerOptionExitP1",true);
				(cmd(stoptweening;linear,0.1;diffusealpha,1;zoom,1;))(self)
			end;
			ExitUnselectedP1Command=function(self)
				setenv("PlayerOptionExitP1",false);
				(cmd(stoptweening;linear,0.1;diffusealpha,0;zoomy,0))(self)
			end;
			OffCommand=cmd(stoptweening;zoom,0);
		};
		LoadActor("1P_WAIT")..{
			OnCommand=cmd(zoom,0);
			OffCommand=cmd(zoom,1;linear,0.1;zoomy,0);
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(player,PLAYER_2;x,230;y,77.5);
		LoadActor("2P_OK")..{
			InitCommand=cmd(diffusealpha,0;zoomy,0);
		--	ExitSelectedP2Command=cmd(stoptweening;bob;effectmagnitude,0,2,0;effectperiod,1;bounceend,0.2;diffusealpha,1;zoom,1);
		--	ExitUnselectedP2Command=cmd(stoptweening;diffusealpha,0;zoomy,0);
			ExitSelectedP2Command=function(self)
				setenv("PlayerOptionExitP2",true);
				(cmd(stoptweening;linear,0.1;diffusealpha,1;zoom,1))(self)
			end;
			ExitUnselectedP2Command=function(self)
				setenv("PlayerOptionExitP2",false);
				(cmd(stoptweening;linear,0.1;diffusealpha,0;zoomy,0))(self)
			end;
			OffCommand=cmd(stoptweening;zoom,0);
		};
		LoadActor("2P_WAIT")..{
			OnCommand=cmd(zoom,0);
			OffCommand=cmd(zoom,1;linear,0.1;zoomy,0);
		};
	};
};