local t = Def.ActorFrame {
	LoadActor("Backing");
--new song
LoadActor("NEW")..{
	InitCommand=cmd(x,-138;y,-25;finishtweening;draworder,1);
	SetCommand=function(self,param)
		if param.Song then
			if PROFILEMAN:IsSongNew(param.Song) then
				self:visible(true);
			else
				self:visible(false);
			end
		else
			self:visible(false);
		end
	end;
};
Def.Sprite{
	InitCommand=cmd(x,-154);
	SetMessageCommand=function(self,params)
	local song = params.Song;
	local pssp1 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P1")
	local staw1 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P1"):GetStageAward();
	local pssp2 = STATSMAN:GetCurStageStats(params.Song):GetPlayerStageStats("PlayerNumber_P2")
		if song then
			if not PROFILEMAN:IsSongNew(params.Song) then
			self:Load(THEME:GetPathG("MusicWheelItem Song","NormalPart/score"));
			self:diffusealpha(1);
			self:draworder(1);
			else
			self:diffusealpha(0);
			end;
		end;
	end;
};
};
return t;