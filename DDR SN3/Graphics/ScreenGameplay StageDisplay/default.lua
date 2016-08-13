local StageDisplay = Def.ActorFrame{
	BeginCommand=cmd(playcommand,"Set";);
	CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set";);
};

if (GAMESTATE:Env()).EndlessState or GAMESTATE:IsCourseMode() then
	StageDisplay[#StageDisplay+1] = Def.Sprite{
		Texture="counter background"
	}
	StageDisplay[#StageDisplay+1] = Def.BitmapText{
		Font="_handelgothic bt 20px",
		Text="",
		InitCommand=function(self) self:zoom(0.7) end,
		SetCommand=function(self, _)
			self:settext(tostring(GAMESTATE:GetAppropriateStageNum()))
		end,
		DoneLoadingNextSongMessageCommand=function(s) s:queuecommand("Set") end
	}
else
	for s in ivalues(Stage) do

	if s ~= 'Stage_Next' and s ~= 'Stage_Nonstop' and s ~= 'Stage_Oni' and s ~= 'Stage_Endless' then
		StageDisplay[#StageDisplay+1] = LoadActor( THEME:GetPathG("ScreenGameplay","StageDisplay/"..s) ) .. {
			SetCommand=function(self, params)
				local Stage = GAMESTATE:GetCurrentStage();
				local StageIndex = GAMESTATE:GetCurrentStageIndex();
				local screen = SCREENMAN:GetTopScreen();
				if screen and screen.GetStageStats then
					local ss = screen:GetStageStats();
					Stage = ss:GetStage();
					StageIndex = ss:GetStageIndex();
				end
				self:visible( Stage == s );
			end;
		};
	end

	end
end

return StageDisplay;