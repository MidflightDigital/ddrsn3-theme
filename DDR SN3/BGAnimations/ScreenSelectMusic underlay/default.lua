local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor( "w01" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+201;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w02" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+167;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w03" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+135;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w04" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+104;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w05" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+75;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w06" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+47;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w07" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+21;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w08" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-3;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w08" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-28;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w10" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-53;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w11" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-79;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w12" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-107;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w13" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-136;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w14" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-167;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}

t[#t+1] = Def.ActorFrame {
	LoadActor( "w15" )..{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-199;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
}
return t