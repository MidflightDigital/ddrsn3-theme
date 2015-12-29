local tt={};
--Get parameter
tt[1],tt[2],tt[3],tt[4],tt[5] = ...

local function ReadOrCreateRadarValueForPlayer(PlayerUID, ValueTable)

	local RadarFile = RageFileUtil:CreateRageFile()
	-- Read RadarValue From File
	
	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D1.txt",1) then --Stram--
		local str = RadarFile:Read();
		ValueTable[1] =tonumber(str);
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D1.txt",2);
		RadarFile:Write("0.0");
		ValueTable[1]=0;
	end
	
	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D2.txt",1) then --Voltage--
		local str = RadarFile:Read();
		ValueTable[2] =tonumber(str);
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D2.txt",2);
		RadarFile:Write("0.0");
		ValueTable[2]=0;
	end
	
	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D3.txt",1) then --Air--
		local str = RadarFile:Read();
		ValueTable[3] =tonumber(str);
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D3.txt",2);
		RadarFile:Write("0.0");
		ValueTable[3]=0;
	end

	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D4.txt",1) then --Freeze--
		local str = RadarFile:Read();
		ValueTable[4] =tonumber(str);
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D4.txt",2);
		RadarFile:Write("0.0");
		ValueTable[4]=0;
	end

	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D5.txt",1) then --Chaos--
		local str = RadarFile:Read();
		ValueTable[5] =tonumber(str);
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D5.txt",2);
		RadarFile:Write("0.0");
		ValueTable[5]=0;
	end	
	RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D1P.txt",2);
	RadarFile:Write(tostring(ValueTable[1]));
	RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D2P.txt",2);
	RadarFile:Write(tostring(ValueTable[2]));
	RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D3P.txt",2);
	RadarFile:Write(tostring(ValueTable[3]));
	RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D4P.txt",2);
	RadarFile:Write(tostring(ValueTable[4]));
	RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_D5P.txt",2);
	RadarFile:Write(tostring(ValueTable[5]));
	RadarFile:Close();
end

local function radarSet(self)
	
	
	self:SetFromValues(PLAYER_1,tt);
	self:visible(true);	
	
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		self:visible(true);
		if MEMCARDMAN:GetCardState(PLAYER_1) == 'MemoryCardState_none' then
			self:visible(true);
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_1);
			if ind > 0 then -------------處理要顯示的內容
			
			local PlayerUID = PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetGUID()  --取得uid
			
			ReadOrCreateRadarValueForPlayer(PlayerUID,tt);


			
			self:SetFromValues(PLAYER_1,tt);
			
			
			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(PLAYER_1, 1) then
					self:visible(false);
					self:queuecommand('UpdateInternal2');
				else
					self:visible(false);
				end;
			end
		else
		--------------------using card
		self:visible(true);
		end
	else
		self:visible(false);
	end
		
end



local t = Def.ActorFrame {

	Name="Radar",
	InitCommand=cmd(Center),

	Def.GrooveRadar {
		OnCommand=cmd(zoom,0;sleep,0.583;decelerate,0.150;zoom,1),
		OffCommand=cmd(sleep,0.00;decelerate,0.167;zoom,0),
		StorageDevicesChangedMessageCommand=function(self, params)
			self:queuecommand('UpdateInternal2');
		end;
		CodeMessageCommand = function(self, params)
			
			if params.Name == 'Up' or params.Name == 'Up2' or params.Name == 'DownLeft' then
				self:queuecommand('UpdateInternal2');
			end;
			if params.Name == 'Down' or params.Name == 'Down2' or params.Name == 'DownRight' then
				self:queuecommand('UpdateInternal2');
			end;
			
		end;
		PlayerJoinedMessageCommand=function(self, params)
			self:queuecommand('UpdateInternal2');
		end;
		PlayerUnjoinedMessageCommand=function(self, params)
			self:queuecommand('UpdateInternal2');
		end;
		
		OnCommand=function(self, params)
			(cmd(zoom,0;sleep,0.583;decelerate,0.150;zoom,1.1))(self);
			self:queuecommand('UpdateInternal2');
		end;

		UpdateInternal2Command=function(self)
			radarSet(self);
		end;
		
		
	},
	
	
}

return t