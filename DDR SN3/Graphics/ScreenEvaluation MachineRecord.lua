local Player = ...
assert(Player,"MachineRecord needs Player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(Player);
local record = stats:GetMachineHighScoreIndex()
local hasMachineRecord = record ~= -1
local t = Def.ActorFrame {};
t[#t+1] = LoadActor("Machine Record2")..{
	InitCommand=cmd(pulse;effectmagnitude,0.85,0.9,0);
	BeginCommand=function(self)
		self:visible(hasMachineRecord);
	end;
};

return t