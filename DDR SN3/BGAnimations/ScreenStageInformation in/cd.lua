if not GAMESTATE:IsCourseMode() then
	local song = GAMESTATE:GetCurrentSong()
	if song then
		local cdPath = song:GetCDImagePath()
		if cdPath then
			return Def.Sprite{
				Texture = cdPath,
				InitCommand = function(s) s:scaletofit(0,0,128,128):playcommand("PostInit") end
			}
		end
	end
end

return Def.Actor{}