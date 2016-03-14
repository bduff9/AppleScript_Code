global currentPlaylist
property okflag : false
property not_these_genres : {"Christmas", "Skit", "Comedy", "Parody", "Instrumental", "A Capella"}
-- check if iTunes is running 
tell application "Finder"
	if (get name of every process) contains "iTunes" then set okflag to true
end tell

-- set current song properties

if okflag then
	tell application "iTunes"
		activate
		set sec to 1
		set min to 60 * sec
		set hr to 60 * min
		display dialog "How many hours should playlist be?" default answer "5.0"
		set inputHR to text returned of the result
		set TimeThreshold to (inputHR as real) * hr
		repeat while duration of current playlist ² TimeThreshold
			if selection is not {} then
				set currentPlaylist to name of current playlist
				set currentTrack to current track
				set currentartist to artist of current track
				set newBPM to bpm of currentTrack
				set newKey to comment of currentTrack
			end if
			
			-- Set proper key and bpms
			
			set keyplaylist to "xDJ " & (newKey)
			set tracknumber to count tracks of playlist keyplaylist
			set minbpm to newBPM - 11
			set maxbpm to newBPM + 11
			set doublebpm to 2 * newBPM
			set halfbpm to newBPM / 2
			set gen to genre of currentTrack
			make new playlist with properties {name:"astemp1"}
			repeat with x from 1 to tracknumber
				set tempbpm to bpm of track x of playlist keyplaylist
				
				if tempbpm is greater than minbpm and tempbpm is less than maxbpm or tempbpm is equal to doublebpm or tempbpm is equal to halfbpm then
					set trackname to name of track x of playlist keyplaylist
					set artistname to artist of track x of playlist keyplaylist
					if (get name of every track of playlist currentPlaylist) does not contain trackname and gen is not in not_these_genres and currentartist is not equal to artistname then
						duplicate track x of playlist keyplaylist to playlist "astemp1"
					end if
				end if
			end repeat
			set results1 to count tracks of playlist "astemp1"
			make new playlist with properties {name:"astemp2"}
			set temprating to rating of track 1 of playlist "astemp1"
			duplicate track 1 of playlist "astemp1" to playlist "astemp2"
			repeat with n from 2 to results1
				if rating of track n of playlist "astemp1" is equal to temprating then
					duplicate track n of playlist "astemp1" to playlist "astemp2"
				else if rating of track n of playlist "astemp1" is greater than temprating then
					delete every file track of user playlist "astemp2"
					duplicate track n of playlist "astemp1" to playlist "astemp2"
					set temprating to rating of track n of playlist "astemp1"
				end if
			end repeat
			set highrate to count tracks of playlist "astemp2"
			if highrate is greater than 1 then
				set keeptrack to "No"
				repeat until keeptrack is "Yes"
					repeat with addtrack from 1 to (count tracks of playlist "astemp2")
						duplicate track addtrack of playlist "astemp2" to playlist currentPlaylist
						display dialog "Keep Track?" buttons {"Yes", "No", "Reset"} default button "Yes"
						set keeptrack to button returned of the result
						if keeptrack is "No" then
							delete last track of playlist currentPlaylist
						else
							if keeptrack is "Reset" then
								my resetplaylist()
								exit repeat
							else
								if keeptrack is "Yes" then
									exit repeat
								end if
							end if
						end if
					end repeat
				end repeat
				if keeptrack is "Reset" then
					exit repeat
				else
					next track
					delete playlist "astemp1"
					delete playlist "astemp2"
				end if
			else
				if highrate is equal to 0 then
					display dialog "No Tracks" buttons {"Remove 1", "Remove 2", "Reset"} default button "Reset"
					set backtrack to button returned of the result
					if backtrack is "Reset" then
						my resetplaylist()
						exit repeat
					else
						if backtrack is "Remove 1" then
							delete last track of playlist currentPlaylist
							play last track of playlist currentPlaylist
						else
							if backtrack is "Remove 2" then
								delete last track of playlist currentPlaylist
								delete last track of playlist currentPlaylist
								play last track of playlist currentPlaylist
							end if
						end if
					end if
				else
					if highrate is equal to 1 then
						display dialog "This is the only track...Keep?" buttons {"Yes", "Remove Tracks", "Reset"} default button "Yes"
						set onetrack to button returned of the result
						if onetrack is "Reset" then
							my resetplaylist()
							exit repeat
						else
							if onetrack is "Remove Tracks" then
								display dialog "Remove how many tracks?"
								delete last track of playlist currentPlaylist
								play last track of playlist currentPlaylist
							else
								if onetrack is "Yes" then
									duplicate track 1 of playlist "astemp2" to playlist currentPlaylist
								end if
							end if
						end if
					end if
					next track
					delete playlist "astemp1"
					delete playlist "astemp2"
				end if
			end if
		end repeat
	end tell
end if

on resetplaylist()
	tell application "iTunes"
		set resetcount to count tracks of playlist currentPlaylist
		repeat with i from resetcount to 2
			delete track i of playlist currentPlaylist
		end repeat
	end tell
end resetplaylist