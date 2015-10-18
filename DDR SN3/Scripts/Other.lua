function TextBannerAfterSet(self,param) 
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")
	local Artist=self:GetChild("Artist")

	if Subtitle:GetText() == "" then
		Title:maxwidth(240)
		Title:y(-7)
		Title:zoom(0.9)

		Subtitle:visible(false)

		Artist:maxwidth(240)
		Artist:y(9)
		Artist:zoom(0.5)
	else
		Title:maxwidth(274)
		Title:zoom(0.8)
		Title:y(-8)

		-- subtitle below title
		Subtitle:visible(true)
		Subtitle:zoom(0.5)
		Subtitle:maxwidth(240)
		Subtitle:y(2)

		Artist:maxwidth(240)
		Artist:y(10)
		Artist:zoom(0.5)
	end

end

-- GetCharAnimPath(sPath)
-- Easier access to Characters folder (taken from ScreenHowToPlay.cpp)
function GetCharAnimPath(sPath) return "/Characters/"..sPath end