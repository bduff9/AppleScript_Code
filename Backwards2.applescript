set aquit to false
repeat until aquit is true
	tell application "Adium.app"
		activate
		delay 2
		display dialog "Enter text:" default answer ""
		set decrypted to text returned of result
		set decrypt to {}
	end tell
	tell application "System Events"
		--set decrypted to (value of text area 1 of scroll area 2 of splitter group 1 of group 1 of window "Sean Greevers" of application process "Adium")
		--display dialog decrypted
		set decrypt to every character of decrypted
		set alength to (count every item of decrypted)
		if alength is 0 then
			set aquit to true
			display dialog "!Eyb"
		else
			set encrypted to {}
			repeat with x from alength to 1 by -1
				set end of encrypted to item x of decrypted
			end repeat
			tell application "Adium.app" to activate
			delay 1
			set value of text area 1 of scroll area 2 of splitter group 1 of group 1 of window 1 of application process "Adium" to "" & encrypted
			keystroke return
		end if
	end tell
end repeat