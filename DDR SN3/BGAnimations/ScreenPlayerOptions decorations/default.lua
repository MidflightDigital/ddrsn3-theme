SOUND:DimMusic(1,math.huge)
local t = LoadFallbackB();
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional("Footer","Footer");
t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
-- other items (balloons, etc.)

local index = 0;
local row = "";
local name = "";
local choice = 0;

function setting(self,screen,pn)
	index = screen:GetCurrentRowIndex(pn);
	row = screen:GetOptionRow(index);
	name = row:GetName();
	choice = row:GetChoiceInRowWithFocus(pn);
	self:settext(THEME:GetString("OptionExplanations",name));
	if name ~= "Exit" then
		if THEME:GetMetric( "ScreenOptionsMaster",name.."Explanation" ) then
			self:settext(THEME:GetString("OptionItemExplanations",THEME:GetMetric( "ScreenOptionsMaster",name.."Explanation" )..""..choice));
		else self:settext("");
		end;
	end;
	return self;
end;

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X-280;y,SCREEN_CENTER_Y+132;zoom,0.55;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP1";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP1Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_1);
      end;
    end;
    MenuLeftP1MessageCommand=cmd(playcommand,"SetP1");
    MenuRightP1MessageCommand=cmd(playcommand,"SetP1");
    MenuUpP1MessageCommand=cmd(playcommand,"SetP1");
    MenuDownP1MessageCommand=cmd(playcommand,"SetP1");
  };
end;

if GAMESTATE:IsHumanPlayer(PLAYER_2) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X+70;y,SCREEN_CENTER_Y+132;zoom,0.55;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP2";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP2Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_2);
      end;
    end;
    MenuLeftP2MessageCommand=cmd(playcommand,"SetP2");
    MenuRightP2MessageCommand=cmd(playcommand,"SetP2");
    MenuUpP2MessageCommand=cmd(playcommand,"SetP2");
    MenuDownP2MessageCommand=cmd(playcommand,"SetP2");
  };
end;


return t
