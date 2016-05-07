-- oh no people are going to be mad at me for using coin mode what ever shall I do
--[[
          ##########          
      ####          ####      
    ##                  ##    
  ##    ####      ####    ##  
  ##  ##XXXX##  ##XXXX##  ##  
##  ##  XXXX  ##  XXXX  ##  ##
##  ##        ##        ##  ##
##    ##    ##  ##    ##    ##
##      ####      ####      ##
##                          ##
  ##                ##    ##  
  ##      ##########      ##  
    ##                  ##    
      ####          ####      
          ##########          
--]]

local coinmode = GAMESTATE:GetCoinMode()
local cointype = coinmode == 'CoinMode_Free' and "_free play" or "_insert coin"

return LoadActor(THEME:GetPathG("ScreenTitleJoin","Messages/"..cointype))