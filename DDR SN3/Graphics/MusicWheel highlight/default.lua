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

return t;