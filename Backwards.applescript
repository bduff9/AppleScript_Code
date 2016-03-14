tell application "Adium.app" to activate
delay 2
set decrypt to {}
tell application "System Events"
	set decrypted to (value of text area 1 of scroll area 2 of splitter group 1 of group 1 of window 1 of application process "Adium")
	display dialog decrypted
	set decrypt to every character of decrypted
	set alength to (count every item of decrypted)
	set encrypted to {}
	repeat with x from alength to 1 by -1
		set end of encrypted to item x of decrypted
	end repeat
	tell application "Adium.app" to activate
	delay 1
	set value of text area 1 of scroll area 2 of splitter group 1 of group 1 of window 1 of application process "Adium" to "" & encrypted
end tell