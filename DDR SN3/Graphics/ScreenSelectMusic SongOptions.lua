return LoadFont("ModIcon text")..{
	BeginCommand=function(self)
		self:playcommand("Update")

		-- todo: check if extra stage and blink if so
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			self:diffuseblink()
		else
			self:stopeffect()
		end
	end;
	SongOptionsChangedMessageCommand=cmd(playcommand,"Update");

	UpdateCommand=function(self)
		self:settext(GAMESTATE:GetSongOptionsString())
	end;
}