local tt={};
--Get parameter
tt[1],tt[2],tt[3],tt[4],tt[5],tt[6],tt[7] = ...
local style = (tt[6] == 1) and 'single' or 'double'
local past = tt[7] == 1

local function radarSet(self)

	self:SetFromValues(PLAYER_1,tt);
	self:visible(true);	
	
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		self:visible(true);
		local profile = PROFILEMAN:GetProfile(PLAYER_1)  --取得uid but not really
		if not past then
			tt = ProfileData.GetRadarDataPackaged(profile, style)
		else
			local env = GAMESTATE:Env()
			local pastVals = env.PastRadarValues
			local myPast = pastVals[PLAYER_1]
			tt = RadarHelpers.PackageArbitraryRadarData(myPast,style)
		end
		self:SetFromValues(PLAYER_1,tt);
	else
		self:visible(false);
	end
end


local t = Def.ActorFrame {

	Name="Radar",
	InitCommand=cmd(Center),

	Def.GrooveRadar {
		OnCommand=function(self, params)
			(cmd(zoom,0;sleep,0.583;decelerate,0.150;zoom,1.1))(self);
			self:queuecommand('UpdateInternal2');
		end;

		UpdateInternal2Command=function(self)
			radarSet(self);
		end;
		OffCommand=cmd(sleep,0.00;decelerate,0.167;zoom,0)
		
	},
	
	
}

return t