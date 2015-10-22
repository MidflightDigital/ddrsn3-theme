local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_shared_title") .. {
		Text=gc:GetText(),
		InitCommand=function(self) self:uppercase(true):shadowlength(2) end,
		OnCommand=function() end,
		GainFocusCommand=function(self) self:stoptweening():diffuse(color("#ffffff")) 
            MESSAGEMAN:Broadcast("TitleSelectionChanged", {Choice=string.lower(gc:GetChoiceName())}) end,
		LoseFocusCommand=function(self) self:stopeffect():diffuse(color("#33CC33")) end
	};
	
};