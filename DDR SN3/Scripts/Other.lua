function TextBannerAfterSet(self,param) 
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")
	local Artist=self:GetChild("Artist")

	if Subtitle:GetText() ~= "" then
		--strip off whitespace at the beginning of the subtitle text
		--and the end of the title text
		local SubtitleText = Subtitle:GetText()
		local TitleText = Title:GetText()
		Title:settext(JoinStringsWithSpace(TitleText, SubtitleText))
	end

	Title:maxwidth(240)
	Title:y(-7)
	Title:zoom(0.9)

	Subtitle:visible(false)

	Artist:maxwidth(240)
	Artist:y(9)
	Artist:zoom(0.5)

end

-- GetCharAnimPath(sPath)
-- Easier access to Characters folder (taken from ScreenHowToPlay.cpp)
function GetCharAnimPath(sPath) return "/Characters/"..sPath end

-- JoinStringsWithSpace(a, b)
-- Joins a pair of strings by a space, removing other whitespace around it.
function JoinStringsWithSpace(a, b)
	return a:gsub("%s*$","").." "..b:gsub("^%s*","")
end