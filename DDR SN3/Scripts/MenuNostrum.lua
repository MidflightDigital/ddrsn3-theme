--Please read the documentation before attempting to create menu definitions.
--If you really screw it up, MenuNostrum will tell you, but if you moderately
--screw it up your menu just won't work.
--Also useful to remember: the string "false" and the number 0 are truthy in Lua!

--obviously if you are not using this in SN3 you might want a different condition
local debug = SN3Debug
local dbg_print = debug and print or (function() end)

local function GetInputCallback(actionFunction, buttonConv, override)
    return function(event)
        assert(useUpDown or useLeftRight, "what the hell are you trying to do")
        local pn = event.PlayerNumber
        local button = event.GameButton
        if GAMESTATE:IsHumanPlayer(pn) then
            local action = nil
            if buttonConv[button] then
                actionFunction(pn, buttonConv[button])
                return override
            end
            dbg_print("no usable input. button:"..button)
        end
        return true
    end
end

local function loadDef(definitionPath)
    menuDef = dofile_safer(definitionPath)
    if not (type(menuDef) == "table") then
        error("you can't have a non-table")
    end

    --now begins the very long type-checking section
    local choices = menuDef.choices
    assert(type(choices)=="table" and #choices>0,
        "choices must be a non-empty table")
    for idx, choice in ipairs(menuDef.choices) do
        assert(type(choice.name) == "string", "name must be a string")
        assert((choice.onGainFocus==nil) or (type(choice.onGainFocus)=="function"),
            "onGainFocus can either be a function or nothing")
        assert((choice.onLoseFocus==nil) or (type(choice.onLoseFocus)=="function"),
            "onLoseFocus can either be a function or nothing")
        assert(type(choice.onSelect) == "function", "onSelect must be a function")
    end
    --this attempts to determine if there "probably aren't enough mappings"
    local mappings = menuDef.mappings
    assert(type(mappings)=="table" and next(mappings)~=nil,
        "mappings must be a non-empty table")
    do
        local iter = nil
        for i=1, 3 do
            iter = next(mapping, iter)
            if not iter then
                Warn("this MenuNostrum definition probably doesn't have enough mappings: "
                    ..definitionPath)
                break
            end
        end
    end
    --we are now confident that this menuDef is good enough, that is, it
    --will not throw errors
end

--it probably takes a long time to do all the shit required to load and
--verify a menu definition so once they're good we cache 'em
local savedDefinitions = {}

function MenuNostrum(definitionPath)
    local menuDef = savedDefinitions[definitionPath]

    if not menuDef then
        --if there's a problem loadDef just errors
        menuDef = loadDef(definitionPath)
    end

    savedDefinitions[definitionPath] = menuDef

    local blocked = false
    local ActionFunction
    do
        local currentIndex = {}
        ActionFunction = function(pn, action)
            local prevIndex = currentIndex[pn]
            local indexChanged = true
            if prevIndex == nil then
                currentIndex[pn] = 0
            elseif action == "next" then
                currentIndex[pn] = currentIndex[pn] + 1
            elseif action == "previous" then
                currentIndex[pn] = currentIndex[pn] - 1
            elseif action == "select" then
                indexChanged = false
                menuDef.choices[currentIndex[pn]].onSelect()
                MESSAGEMAN:Broadcast("MNSelection",
                    {pn=pn,
                    choice = menuDef.choices[currentIndex[pn]].name}
                )
            else
                indexChanged = false
            end
            if indexChanged then
                if prevIndex then
                    menuDef.choices[prevIndex].onLoseFocus()
                end
                menuDef.choices[currentIndex[pn]].onGainFocus()
                MESSAGEMAN:Broadcast("MNFocusChanged",
                    {pn=pn,
                    newChoice=menuDef.choices[currentIndex[pn]].name,
                    oldChoice=menuDef.choices[prevIndex].name}
                )
            end
        end
    end

    return Def.Actor{
        Name="MenuNostrum";
        OnCommand=function(s) SCREENMAN:GetTopScreen:AddInputCallback() end
    }
end
