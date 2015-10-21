local jl = Var "JudgmentLine";

local jlToFrameNum = {
	JudgmentLine_W1 = 0,
	JudgmentLine_W2 = 1,
	JudgmentLine_W3 = 2,
	JudgmentLine_W4 = 3,
	JudgmentLine_W5 = 4,
	JudgmentLine_Miss = 5,
	JudgmentLine_Held = 6,
	JudgmentLine_MaxCombo = 7,
};

return Def.ActorFrame{
	LoadActor("_judge labels")..{
		InitCommand=cmd(animate,false;setstate,jlToFrameNum[jl]);
	};
};