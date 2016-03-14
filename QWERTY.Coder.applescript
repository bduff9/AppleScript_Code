set choice to "Continue"
repeat until choice is "Exit"
	set original to "abcdefghijklmnopqrstuvwxyz"
	set bank to "qwertyuiopasdfghjklzxcvbnm"
	tell application "Finder"
		display dialog "Decode or Encode?" buttons {"Decode", "Encode", "Cancel"}
		set code to button returned of result
		if code is "Decode" then
			display dialog "Enter coded text:" default answer ""
			set codedtext to (every character of (text returned of result))
			set uncoded to ""
			repeat with this_char in codedtext
				if bank contains this_char then
					set y to offset of this_char in bank
					if y is 1 then set y to 27
					set uncoded to uncoded & item (y - 1) of bank
				else
					set uncoded to uncoded & this_char
				end if
			end repeat
			set uncodedstring to ((uncoded) as string)
			display dialog "Input:   " & codedtext & return & "Output: " & uncodedstring
			tell application "Adium.app" to set the clipboard to uncodedstring
		else
			display dialog "Enter text to encode:" default answer ""
			set decodedtext to text returned of result
			set decodedtext to (every character of decodedtext)
			set coded to {}
			repeat with this_char in decodedtext
				if bank contains this_char then
					set y to offset of this_char in bank
					if y is 26 then set y to 0
					set coded to coded & item (y + 1) of bank
				else
					set coded to coded & this_char
				end if
			end repeat
			set codedstring to ((coded) as string)
			display dialog "Input:   " & decodedtext & return & "Output: " & codedstring
			tell application "Adium.app" to set the clipboard to codedstring
		end if
		display dialog "Continue or Exit?" buttons {"Continue", "Exit"}
		set choice to button returned of result
	end tell
end repeat