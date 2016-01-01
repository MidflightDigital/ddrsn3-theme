local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathS("","_swoosh"))..{ 
	OnCommand=cmd(play);
}

return t