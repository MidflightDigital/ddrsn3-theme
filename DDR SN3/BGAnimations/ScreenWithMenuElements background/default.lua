return Def.ActorFrame{
	LoadActor("video")..{
		InitCommand=cmd(FullScreen);
	};
}