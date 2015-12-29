-- by not prefixing "local" before this variable,
-- it will have global scope throughout your theme
-- and can be accessed from any other theme file
ItemThatWasJustUnlocked = nil

function UnlockSomeStuffMaybe(text)
	
	-- How many unlocks are there? Get the number.
	local HowMany = UNLOCKMAN:GetNumUnlocks()
	
	if HowMany > 0 then
		
		-- Use the text that was typed to see if it matches any "Codes" set under
		-- [UnlockManager] in your Metrics.ini
		local UnlockSongs = UNLOCKMAN:GetSongsUnlockedByEntryID(text)
		
		-- The line above returns a table whether it finds anything or not
		-- so check the size of that table.
		if #UnlockSongs > 0 then
			
			local group = UnlockSongs[1]:GetGroupName()
			local title = UnlockSongs[1]:GetDisplayFullTitle()
			
			-- create a path out of the song's group and title
			local path = group.."/"..title
					
			-- set the variable with global scope equal to the path
			-- we'll use this variable later on ScreenUnlock2
			ItemThatWasJustUnlocked = path
			
			--unlock that song using the text the user typed in
			UNLOCKMAN:UnlockEntryID(text)
		else
		
			-- the lookup didn't find any locked content that matched the typed text
			-- so set this variable to nil
			ItemThatWasJustUnlocked = nil
		end
	
	end
end