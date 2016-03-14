tell application "Finder"
	activate
	set choice to "Continue"
	display dialog "Use old key or generate new one?" buttons {"Use my key", "Generate new key"}
	set keytype to button returned of result
	set original to "abcdefghijklmnopqrstuvwxyz"
	set zeronine to "jabcdefghi"
	set tentwenty to "yz"
	--set code bank
	if keytype is "Generate new key" then
		set original to "abcdefghijklmnopqrstuvwxyz"
		set zeronine to "jabcdefghi"
		set tentwenty to "yz"
		set bank to {}
		set codekey to {}
		repeat until (count every item of bank) is equal to 26
			set x to random number from 1 to 26
			if bank does not contain item x of original then
				set end of bank to item x of original
				set end of codekey to x
			end if
		end repeat
		set newkey to {}
		repeat with charindex in codekey
			set end of newkey to 27 - charindex
		end repeat
		set thekey to {}
		repeat with charindex in newkey
			set numberz to every character of ((charindex) as string)
			if (count every item of numberz) is 1 then
				set end of thekey to item (charindex + 1) of zeronine
			else
				set end of thekey to item (item 1 of numberz) of tentwenty
				set end of thekey to item ((item 2 of numberz) + 1) of zeronine
			end if
		end repeat
		set thekey to ((thekey) as string)
		set keytemp to ""
		set breakcount to 0
		repeat with z from 1 to (count every character of thekey)
			if breakcount is 4 then
				set keytemp to keytemp & " "
				set breakcount to 0
			end if
			set keytemp to keytemp & item z of thekey
			set breakcount to breakcount + 1
		end repeat
		repeat
			set wordz to (get every word of keytemp)
			if (count every character of item (count every item of wordz) of wordz) is less than 4 then
				set keytemp to keytemp & item (random number from 1 to 26) of bank
			else
				exit repeat
			end if
		end repeat
		set thekey to keytemp
	else --interpret old key
		set iskey to false
		repeat until iskey is true
			display dialog "Enter key string:" default answer ""
			set oldkey to text returned of result
			set thekey to oldkey
			set wordz to (every word of oldkey)
			set iskey to true
			repeat with this_word in wordz
				set charz to every character of this_word
				set charcount to count every item of charz
				if charcount is equal to 4 and iskey then
					set iskey to true
				else
					set iskey to false
				end if
			end repeat
			if iskey is false then display dialog "Key is not in correct format... Please check and try again..."
		end repeat
		set adj to 0
		set keylist to {}
		repeat with a from 1 to (count every character of oldkey)
			if zeronine contains item a of oldkey or tentwenty contains item a of oldkey then set end of keylist to item a of oldkey
		end repeat
		set keynumbers to {}
		repeat with b from 1 to (count every item of keylist)
			set newnumber to 0
			if tentwenty contains item (b + adj) of keylist then
				set newnumber to (offset of (item (b + adj) of keylist) in tentwenty) * 10
				set newnumber to newnumber + (offset of (item (b + adj + 1) of keylist) in zeronine) - 1
				set end of keynumbers to newnumber
				set adj to adj + 1
				if (count every item of keynumbers) is 26 then exit repeat
			else
				set newnumber to newnumber + (offset of (item (b + adj) of keylist) in zeronine) - 1
				set end of keynumbers to newnumber
				if (count every item of keynumbers) is 26 then exit repeat
			end if
		end repeat
		set propernumbers to {}
		repeat with this_number in keynumbers
			set end of propernumbers to 27 - this_number
		end repeat
		set bank to {}
		repeat with new_number in propernumbers
			set end of bank to item new_number of original
		end repeat
	end if
	display dialog thekey
	tell application "Finder" to set the clipboard to thekey
	set bank to ((bank) as string)
	--display dialog bank
	repeat until choice is "Exit"
		tell application "Finder"
			display dialog "Decode or Encode?" buttons {"Decode", "Encode", "Cancel"}
			set code to button returned of result
			if code is "Encode" then
				display dialog "Enter message to be encoded:" default answer ""
				set message to text returned of result
				set encoded to ""
				repeat with this_char in message
					set char_index to offset of this_char in original
					if char_index is greater than 0 then
						set new_char to item char_index of bank
						set encoded to encoded & new_char
					end if
				end repeat
				set temp to ""
				set breakcount to 0
				repeat with y from 1 to (count every character of encoded)
					if breakcount is 4 then
						set temp to temp & " "
						set breakcount to 0
					end if
					set temp to temp & item y of encoded
					set breakcount to breakcount + 1
				end repeat
				repeat
					set wordz to (get every word of temp)
					if (count every character of item (count every item of wordz) of wordz) is less than 4 then
						set temp to temp & item (random number from 1 to 26) of bank
					else
						exit repeat
					end if
				end repeat
				set encoded to temp
				tell application "Finder" to set the clipboard to encoded
				display dialog "Original message: " & message & return & "Encoded message: " & encoded
			else -- code is "Decode"
				set iscode to false
				repeat until iscode is true
					display dialog "Enter message to be decoded:" default answer ""
					set encoded to text returned of result
					set wordz to (every word of encoded)
					set iscode to true
					repeat with this_word in wordz
						set charz to every character of this_word
						set charcount to count every item of charz
						if charcount is equal to 4 and iscode then
							set iscode to true
						else
							set iscode to false
						end if
					end repeat
					if iscode is false then display dialog "Code is not in correct format... Please check and try again..."
				end repeat
				set message to ""
				repeat with this_char in encoded
					set char_index to offset of this_char in bank
					if char_index is greater than 0 then
						set new_char to item char_index of original
						set message to message & new_char
					end if
				end repeat
				tell application "Finder" to set the clipboard to message
				display dialog "Encoded message: " & encoded & return & "Original message: " & message
			end if
			--get message to be encoded/decoded
			--encode/decode
			--return message
			display dialog "Continue or Exit?" buttons {"Continue", "Exit"}
			set choice to button returned of result
		end tell
	end repeat
end tell