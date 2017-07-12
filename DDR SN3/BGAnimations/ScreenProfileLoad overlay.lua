local x = Def.ActorFrame{};

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(0); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

x[#x+1] = Def.Quad{
	InitCommand=cmd(FullScreen;diffuse,Color("Black"));
};

return x;
