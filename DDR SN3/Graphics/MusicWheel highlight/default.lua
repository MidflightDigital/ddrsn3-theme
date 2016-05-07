local t = Def.ActorFrame {
	LoadActor("Backing");
	 Def.Sprite{
    Texture=THEME:GetPathG("MusicWheelItem Song","NormalPart/score");
    InitCommand=function(s) s:x(-155) end;
    CurrentSongChangedMessageCommand=function(self,params)
    local song = GAMESTATE:GetCurrentSong();
        if song then
            if not PROFILEMAN:IsSongNew(song) then
            self:visible(true);
            self:draworder(1);
            else
            self:visible(false);
            end;
        else
            self:visible(false);
        end
    end;
};
};

if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
t[#t+1] = Def.ActorFrame {
	LoadActor("frame")..{
		BeginCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:croptop(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropbottom(0.5)
			end
		end;
	};
};
end

return t;