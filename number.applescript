set code to "No"
if code is "No" then
	set firstdigit to 0
	set seconddigit to 0
	set thirddigit to 0
	set fourthdigit to 0
	repeat with x from 0 to 9
		set firstdigit to x
		repeat with y from 0 to 9
			set seconddigit to y
			repeat with a from 0 to 9
				set thirddigit to a
				repeat with b from 0 to 9
					set fourthdigit to b
					set fullcode to [x, y, a, b]
					display dialog "Is the code " & fullcode & "?" buttons {"Yes", "No"} default button "Yes"
					set code to button returned of the result
					if code is "Yes" then
						exit repeat
					end if
				end repeat
				if code is "Yes" then
					exit repeat
				end if
			end repeat
			if code is "Yes" then
				exit repeat
			end if
		end repeat
		if code is "Yes" then
			exit repeat
		end if
	end repeat
end if