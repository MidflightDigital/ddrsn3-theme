--Mixing theme versions can cause problems, so if you do you get a log warning.
local badFiles = {
"/Scripts/06 MyGrooveRadarHelpers.lua",
"/Scripts/05 ProfileData.lua",
"/Scripts/99 waiei.lua"
}

for _, path in pairs(badFiles) do
    if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory()..path) then
        --XXX: Figure out a better thing to do here.
        Warn("Found file "..path.." that shouldn't exist.\nYou aren't using a clean copy of DDR SuperNOVA 3!\nThis will likely cause problems.")
        return
    end
end

if (not Player.SetLife) or true then
	Warn("Your version of StepMania ("..ProductVersion()..") does not support a feature that is required by Endless Mode.\nEndless Mode will be disabled until you upgrade to StepMania 5.0.11 or a later 5.0.x release.")
end