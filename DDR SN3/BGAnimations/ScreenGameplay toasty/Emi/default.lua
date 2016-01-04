local t = Def.ActorFrame{};

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') and GAMESTATE:IsHumanPlayer('PlayerNumber_P1') == true and GAMESTATE:GetCurrentStyle():GetName() == "single" then
t[#t+1] = Def.ActorFrame {
	LoadActor("../toasty_maskP1 Single")..{
		InitCommand=cmd(diffusealpha,0;zwrite,1;blend,Blend.NoEffect;;clearzbuffer,true;x,SCREEN_RIGHT-120;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.8;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180-20;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;linear,0.3;addy,120;linear,0.5;diffusealpha,0;sleep,0.1;addy,-120);
	};
	LoadActor("toasty_circles")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180+20;y,SCREEN_CENTER_Y+40;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,1;linear,0.3;addy,120;linear,0.5;diffusealpha,0;sleep,0.1;addy,-120);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;x,SCREEN_RIGHT-180;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
};
elseif GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') and GAMESTATE:IsHumanPlayer('PlayerNumber_P2') == true and GAMESTATE:GetCurrentStyle():GetName() == "single" then
t[#t+1] = Def.ActorFrame {
	LoadActor("../toasty_maskP2 Single")..{
		InitCommand=cmd(diffusealpha,0;zwrite,1;clearzbuffer,true;blend,Blend.NoEffect;;halign,0;x,SCREEN_WIDTH-120;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;halign,0;x,SCREEN_WIDTH-120;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(ztest,true;diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
	};
	LoadActor("toasty_bg")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;halign,0;x,SCREEN_WIDTH-120;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;diffusealpha,0.8;linear,0.668;addx,56;linear,0.1;diffusealpha,0;sleep,0.1;addx,-56);
	};
	LoadActor("toastyChar")..{
		InitCommand=cmd(diffusealpha,0;;halign,0;x,SCREEN_WIDTH-120;y,SCREEN_CENTER_Y+44;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
	};
	LoadActor("toasty_gradient")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add;;halign,0;x,SCREEN_WIDTH-120;y,SCREEN_CENTER_Y;);
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;linear,0.5;diffusealpha,0);
	};
}
end

return t