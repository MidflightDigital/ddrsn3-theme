local charP1 = GAMESTATE:GetCharacter('PlayerNumber_P1'):GetDisplayName();
local charP2 = GAMESTATE:GetCharacter('PlayerNumber_P2'):GetDisplayName();


local t = Def.ActorFrame{
        Def.Quad{
                BeginCommand=function(self)
                        if IsSMOnlineLoggedIn('PlayerNumber_P1') then
                                self:visible(true):x(SCREEN_CENTER_X*1.5);
                        elseif IsSMOnlineLoggedIn('PlayerNumber_P2') then
                                self:visible(true):x(SCREEN_CENTER_X*0.5);
                        else
                                self:visible(false);
                        end;
                end;
                InitCommand=function(self)
                        self:setsize(280,SCREEN_HEIGHT):CenterY():diffuse(color("0,0,0,0.5"));
                end;
        };
};
--[[
if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory().."Characters/ToastyImages/" .. charP1.."/toastyChar.png") and GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
        t[#t+1] = Def.ActorFrame {
                InitCommand=function(self)
                        if GAMESTATE:GetCurrentStyle():GetName() == "single" then
                                self:x(SCREEN_RIGHT-180);
                                self:y(SCREEN_CENTER_Y);
                        elseif GAMESTATE:GetCurrentStyle():GetName() == "versus" then
                                self:x(SCREEN_CENTER_X);
                                self:y(SCREEN_CENTER_Y-120);
                                self:draworder(-1);
                        end;
                end;
                ComboChangedMessageCommand=function(s, params)
                    if not params.Player == 'PlayerNumber_P1' then return end
                    local combo = params.PlayerStageStats:GetCurrentCombo()
                    if (combo==25) or (combo%50 == 0) then
                        local c = s:GetChildren()
                        for _, child in pairs(c) do
                            child:queuecommand("Animate")
                        end
                    end
                end;
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_bg")..{
                InitCommand=cmd(setsize,200,SCREEN_HEIGHT);
                AnimateCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,1;sleep,1;linear,0.166;diffusealpha,0);
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_bg")..{
                InitCommand=cmd(setsize,200,SCREEN_HEIGHT;blend,Blend.Add;;);
                        AnimateCommand=function(self)
                                local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
                                local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
                                self:customtexturerect(0,0,w*0.5,h*SCREEN_HEIGHT);
                                self:texcoordvelocity(-0.5,0);
                        end;
                        AnimateCommand=cmd(diffusealpha,0;linear,0.166;diffusealpha,0.4;sleep,1;linear,0.166;diffusealpha,0);
                };
                Def.Sprite{
                        AnimateCommand=cmd(finishtweening;y,44;diffusealpha,0;sleep,0.066;linear,0.1;addy,-4;diffusealpha,1;linear,1;addy,-10;linear,0.1;addy,-4;diffusealpha,0;sleep,0.1;addy,18);
                        ComboChangedMessageCommand=function(self, params)
                        if params.Player ~= 'PlayerNumber_P1' then return end
                        local CurCombo = params.PlayerStageStats:GetCurrentCombo()
                                if CurCombo >= 100 and CurCombo%50 == 0 then
                                        self:Load(THEME:GetCurrentThemeDirectory().."/Characters/ToastyImages/" .. charP1 .. "/toasty100Char.png");
                                elseif CurCombo == 25 then
                                        self:Load(THEME:GetCurrentThemeDirectory().."/Characters/ToastyImages/" .. charP1 .. "/toastyChar.png");
                                end;
                        end;
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_circles")..{
                        AnimateCommand=cmd(blend,Blend.Add;;finishtweening;x,-40;zoomy,4;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,0.5;accelerate,0.5;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_circles")..{
                        AnimateCommand=cmd(blend,Blend.Add;;finishtweening;x,40;y,40;zoomy,4;diffusealpha,0;sleep,0.166;linear,0.1;diffusealpha,0.5;accelerate,0.4;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_circles")..{
                        AnimateCommand=cmd(blend,Blend.Add;;finishtweening;x,20;y,60;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.233;linear,0.1;diffusealpha,0.5;accelerate,0.3;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_circles")..{
                        AnimateCommand=cmd(blend,Blend.Add;;finishtweening;x,-20;y,40;zoomx,1;zoomy,2;diffusealpha,0;sleep,0.3;linear,0.1;diffusealpha,0.5;accelerate,0.6;addy,-SCREEN_HEIGHT;linear,0.3;diffusealpha,0;sleep,0.1;addy,SCREEN_HEIGHT);
                };
                LoadActor("../Characters/ToastyImages/" .. charP1 .. "/toasty_gradient")..{
                        InitCommand=cmd(setsize,200,SCREEN_HEIGHT);
                        AnimateCommand=cmd(finishtweening;blend,Blend.Add;;diffusealpha,0;sleep,0.166;linear,0.5;diffusealpha,0.8;sleep,0.5;linear,0.2;diffusealpha,0);
                };
        };
end;
--]]
return t;
