local t = LoadFallbackB()

-- top message
t[#t+1] = StandardDecorationFromFile("CoinMessage","CoinMessage")
t[#t+1] = StandardDecorationFromFile("Freeplay","Freeplay")

-- scrolling message
if PREFSMAN:GetPreference("Premium") ~= 'Premium_Off' then
	t[#t+1] = StandardDecorationFromFile("Premium","Premium")
end

return t