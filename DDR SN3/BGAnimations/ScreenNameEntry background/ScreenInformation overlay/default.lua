-- ScreenInformation
local curIndex = 1;
if getenv("InfoIndex") then
	curIndex = tonumber(getenv("InfoIndex"))
end

--[[
local otherPages = GetInfoPages()
if #otherPages > 1 then
	for i=1,#otherPages do
		infoPages[#infoPages+1] = otherPages[i]
	end
end
--]]

local function MakeInfoItem(item)
	local itemColor = color("#FFFFFF");
	if item.Color then itemColor = item.Color; end
	return LoadFont("_arial black 20px")..{
		Text=THEME:GetString("ScreenInformationTitles",item.Name);
		InitCommand=cmd(y,-1;halign,0;zoom,0.75;diffuse,itemColor);
	};
end;

local infoItems = {}
local selectorOffset = WideScale(108,0)
for i=1,#infoPages do
	infoItems[#infoItems+1] = Def.ActorFrame{
		Def.ActorFrame{
			Name="SelectorFrame";
			InitCommand=cmd(x,SCREEN_CENTER_X-182;y,8;);
			BeginCommand=cmd(playcommand,"Set");
			GainFocusCommand=cmd(visible,true);
			LoseFocusCommand=cmd(visible,false);
			MoveScrollerMessageCommand=cmd(playcommand,"Set");
			SetCommand=function(self,param)
				if infoPages[curIndex].Name == infoPages[i].Name then
					self:playcommand("GainFocus");
				else
					self:playcommand("LoseFocus");
				end;
			end;
			Def.Quad{
				InitCommand=cmd(addx,selectorOffset;y,-8;zoomto,581,24;diffuse,color("0,0,0,0.25"));
			};
			LoadActor("_selector")..{
				Name="Selector";
				InitCommand=cmd(addx,selectorOffset);
			};
			LoadFont("_green gradient")..{
				Name="IndexText";
				InitCommand=cmd(x,250;addx,selectorOffset;y,14;queuecommand,"Set";diffuseblink;effectcolor1,color("1,1,1,1");effectcolor2,color("#EFB500");effectperiod,0.25;strokecolor,color("#B51800"));
				OnCommand=cmd(queuecommand,"Anim");
				AnimCommand=cmd(diffuse,color("#C8F800");strokecolor,color("#5008B0");sleep,0.1;queuecommand,"Anim2");
				Anim2Command=cmd(diffuse,color("#D0E800");strokecolor,color("#B01800");sleep,0.1;queuecommand,"Anim");
				SetCommand=function(self)
					self:settext(curIndex.."/"..#infoPages);
				end;
				MoveScrollerMessageCommand=cmd(playcommand,"Set");
			};
		};
		MakeInfoItem(infoPages[i]);
	};
end

local t = Def.ActorFrame{
	Def.Actor{
		Name="InputHandler";
		MenuUpP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Up", }); end;
		MenuUpP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Up", }); end;
		MenuDownP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Down", }); end;
		MenuDownP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Down", }); end;
		MenuStartP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Start", }); end;
		MenuStartP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Start", }); end;
		MenuInputMessageCommand=function(self,param)
			if param.Input == "Start" then
				-- move on.
				local selInfoPage = infoPages[curIndex]
				setenv("InfoIndex",curIndex)
				setenv("NumInfoItems",#infoPages)
				if selInfoPage.Screen then
					setenv("NextInfoScreen",selInfoPage.Screen)
				else
					setenv("NextInfoScreen","ScreenInformationSubPage")
					setenv("InfoSubPage",selInfoPage.SubPage)
					setenv("InfoSubPageName",selInfoPage.Name)
					setenv("InfoSubPageColor",selInfoPage.Color or color("#FFFFFF"))
				end
				local TopScreen = SCREENMAN:GetTopScreen()
				TopScreen:PostScreenMessage("SM_BeginFadingOut",0);
			else
				-- direction
				if param.Input == "Up" then
					if curIndex > 1 then
						curIndex = curIndex - 1
						MESSAGEMAN:Broadcast("MoveScroller",{Input = param.Input});
					end;
				elseif param.Input == "Down" then
					if curIndex < #infoPages then
						curIndex = curIndex + 1
						MESSAGEMAN:Broadcast("MoveScroller",{Input = param.Input});
					end;
				end;
			end;
		end;
	};
	Def.ActorScroller{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-126;halign,0);
		NumItemsToDraw=18;
		TransformFunction=function(self,offset,itemIndex,numItems)
			local bNoDraw = offset < 0 or offset > 8;
			self:x(bNoDraw and -SCREEN_WIDTH or -247);
			self:y(32*(offset));
		end;
		children=infoItems;
		MoveScrollerMessageCommand=function(self,param)
			-- scroll if the time is right.
			local curScrollerItem = self:GetCurrentItem()
			if curIndex <= 9 and curScrollerItem - 9 <= 0 then
				self:SetCurrentAndDestinationItem(0)
			else
				self:SetCurrentAndDestinationItem(curIndex-9)
			end
		end
	};
};

return t;