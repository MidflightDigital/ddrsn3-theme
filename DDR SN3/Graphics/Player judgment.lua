--Player judgment.lua
--From _fallback, author unclear
--Stripped and remodeled for DDR SN3
local c;
local player = Var "Player";

local JudgeCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW5Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissCommand" );
};

local StJudgeCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW1Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW1Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW4Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissCommand" );
};

local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};

--frame 1 is the Early frame, 2 is the Late frame and doesn't appear in the table
--it is added by code downstream
local StTNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 0;
	TapNoteScore_W3 = 0;
	TapNoteScore_W4 = 1;
	TapNoteScore_W5 = 1;
	TapNoteScore_Miss = 3;	
};

local env = GAMESTATE:Env();
local starterMode = env.StarterMode == true;
local activeFrames = starterMode and StTNSFrames or TNSFrames;
local activeCmds = starterMode and StJudgeCmds or JudgeCmds;
local showEarlyLate = SN3Debug

local t = Def.ActorFrame {

	
	InitCommand = function(self)
		c = self:GetChildren();
	end;

	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;

		local iNumStates = c.Judgment:GetNumStates();
		local iFrame = activeFrames[param.TapNoteScore];
		if not iFrame then return end
		
		local iTapNoteOffset = param.TapNoteOffset;
		local late = iTapNoteOffset and (iTapNoteOffset < 0);
		
		if starterMode and (iFrame == 1 and late) then
			iFrame = 2;
		end;
		
		self:playcommand("Reset");

		c.Judgment:setstate( iFrame );
		c.Judgment:visible( true );
		activeCmds[param.TapNoteScore](c.Judgment);
		if showEarlyLate then
			---XXX: don't hardcode this
			if param.TapNoteScore ~= 'TapNoteScore_W1' then
				c.EarlyLate:visible(true);
				c.EarlyLate:setstate( late and 2 or 1 );
				activeCmds[param.TapNoteScore](c.EarlyLate);
			else
				c.EarlyLate:visible(false);
			end
		end
	end;
};

t[#t+1] = LoadActor(THEME:GetPathG("Judgment",starterMode and "Starter" or "Normal")) .. {
	Name="Judgment";
	InitCommand=cmd(pause;visible,false);
	OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
	ResetCommand=cmd(finishtweening;stopeffect;visible,false);
};

if showEarlyLate then
	t[#t+1] = LoadActor(THEME:GetPathG("Judgment","Starter")) .. {
		Name="EarlyLate";
		InitCommand=cmd(x,80;y,48;pause;visible,false);
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
end

return t;
