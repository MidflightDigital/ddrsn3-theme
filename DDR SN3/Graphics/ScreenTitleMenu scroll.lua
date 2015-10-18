local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_shared_title") .. {
		Text=gc:GetText();
		InitCommand=cmd(uppercase,true;shadowlength,2);
		OnCommand=cmd();
		GainFocusCommand=cmd(stoptweening;diffuse,color("#ffffff"));
		LoseFocusCommand=cmd(stopeffect;diffuse,color("#33CC33"));
	};
	
};