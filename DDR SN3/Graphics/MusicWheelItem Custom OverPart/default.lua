local t = Def.ActorFrame{};

local set;

local RDGtext = THEME:GetString("MusicWheel","CustomItemRDGText");

local t = Def.ActorFrame {
	LoadActor("../_section inner")..{
		SetMessageCommand=function(self, params)
			if params.Label == RDGtext then
				self:diffuse(color("#ff266d"));
			end;
		end;
	};
	LoadActor("../_section outer");
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
		InitCommand=cmd(halign,0;x,-140;);
		SetMessageCommand=function(self,params)
			self:visible(true);
			if params.Label == RDGtext then
				self:Load(THEME:GetPathG("","MusicWheelItem Custom OverPart/_MusicRCD (doubleres).png"))
			end;
		end;
	};
};

return t;
