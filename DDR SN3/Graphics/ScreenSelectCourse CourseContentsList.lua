local maxVisibleContents = 5 -- equivalent of MAX_VISIBLE_CONTENTS
local maxTotalContents = 56 -- equivalent of MAX_TOTAL_CONTENTS
local entryHeight = 44
local itemSecondsPause = 0.75

return Def.ActorFrame{
	Def.Quad{
		Name="TopMask";
		InitCommand=cmd(valign,0;y,-(entryHeight*(maxVisibleContents));zoomto,280,entryHeight*2.5;MaskSource);
	};

	-- course contents list = rage
	Def.CourseContentsList{
		NumItemsToDraw=maxVisibleContents;
		MaxSongs=maxTotalContents;
		SecondsPerItem=itemSecondsPause;

		TransformFunction=function(self,offset,itemIndex,numItems)
			self:y(offset*entryHeight)
		end;

		BeginCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			self:SetFromGameState()
			self:SetCurrentAndDestinationItem(0)
			self:PositionItems()

			self:SetLoop(true)
			self:SetPauseCountdownSeconds(1)
			self:SetSecondsPauseBetweenItems(itemSecondsPause)
			self:ScrollWithPadding(-2,1)
		end;

		Display=Def.ActorFrame{
			InitCommand=cmd(setsize,262,38);
			LoadActor(THEME:GetPathG("CourseEntryDisplay","bar"));

			-- entry number
			LoadFont("Common Course")..{
				InitCommand=cmd(x,-110);
				SetSongCommand=function(self,param)
					self:settext(param.Number)
				end;
			};

			-- textbanner
			Def.TextBanner{
				InitCommand=cmd(x,-89;y,4;zoom,0.8;draworder,99;Load,"TextBanner";SetFromString,"","","","","","");
				SetSongCommand=function(self,param)
					if not param.Song or param.Secret then
						-- set fake ("??????????" with no artist)
						self:SetFromString("??????????","??????????", "","", "","")
						self:diffuse(color("#FFFFFF"))
					else
						-- set real
						self:SetFromSong(param.Song)
						self:diffuse(SONGMAN:GetSongColor(param.Song))
					end
				end;
			};

			-- if you can't do it the right way, do it the hacky way.
			LoadActor(THEME:GetPathF("StepsDisplay","ticks 2x1.png"))..{
				Name="FootClanMembershipToken"; -- teenage mutant ninja stepmania
				InitCommand=cmd(x,90;y,9;pause;);
				SetSongCommand=function(self,param)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			};
			LoadFont("ScreenMusicScroll titles")..{
				Name="DifficultyMeter";
				InitCommand=cmd(x,100;y,12;zoom,0.8);
				SetSongCommand=function(self,param)
					self:settext(param.Meter)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			};

			-- modifiers
			LoadFont("Common normal")..{
				InitCommand=cmd(x,128;y,10;halign,1;zoom,0.5);
				SetSongCommand=function(self,param)
					self:settext(param.Modifiers)
				end;
			};
		};
	};
};