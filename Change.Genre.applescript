tell application "iTunes"
	set okflag to false
	repeat
		set oldtracks to count tracks of playlist "Music"
		repeat
			set newtracks to count tracks of playlist "Music"
			if oldtracks is not equal to newtracks then
				repeat with x from 1 to newtracks
					set equalizer to EQ of track x of playlist "Music"
					if equalizer is equal to "" then
						set EQ of track x of playlist "Music" to "Dance"
						set okflag to true
					end if
				end repeat
			end if
			if okflag is true then exit repeat
		end repeat
	end repeat
end tell