set codelength to 1
set code to 33345
set check to ""
set currlength to (count every character of check)
set foundcode to false

repeat until currlength is equal to codelength
	set check to adddigit(check)
	set currlength to (count every character of check)
	--display dialog "The current length is " & currlength
end repeat

repeat until foundcode is true
	--display dialog "The current code is " & check
	if ((check as string) as integer) is equal to code then
		set foundcode to true
	else
		set temp to incrementone(check)
		copy temp to check
		set currlength to (count every character of check)
		--display dialog "The incremented code is " & check
	end if
end repeat
display dialog "Found code! Code was " & check

on adddigit(check)
	set check to "0" & check
	--display dialog "The digit added code is " & check
	return check
end adddigit

on incrementone(check)
	set digits to {}
	--display dialog "Here is the digit:" & check
	set checkasstring to "" & check
	set digits to (get every character of checkasstring)
	--display dialog "The digits to increment are " & digits
	set countdigits to (count every item of digits)
	set nextdigit to ((item countdigits of digits) as integer)
	set incremented to false
	repeat until incremented is true
		if nextdigit is less than 9 then
			set nextdigit to nextdigit + 1
			set addnew to false
			set (item countdigits of digits) to nextdigit
			set incremented to true
		else if nextdigit is equal to 9 then
			set (item countdigits of digits) to "0"
			if countdigits is greater than 1 then
				set countdigits to countdigits - 1
				set nextdigit to ((item countdigits of digits) as integer)
			else
				set addnew to true
				exit repeat
			end if
		end if
	end repeat
	if addnew is false then
		copy digits to check
	else
		set digits to adddigit(digits)
		--display dialog "" & digits
		copy digits to check
	end if
	return check
end incrementone