(*
MacPass AutoFiller
Created by George Snow 23-March-2019
Copyright © 2019 George Snow. All rights reserved.

no warranty, as is ....use at your own risk and peril

credit to: jacbolus
for the menu clickers 
http://hints.macworld.com/article.php?story=20060921045743404

IMPORTANT NOTES:
1-Like AutoType you must select the right field. when triggering the autofill
2-Password after just selecting Username is store for 10 secs
in the clipboard and then delelted and the app closes



*)

set emptyClip to ""
tell application "Safari"
	set theURL to URL of front document
end tell
set myTestString to theURL

set myArray to my theSplit(myTestString, "/")

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit

repeat with theString in myArray
	if the theString does not contain "." then
		
		
	else
		set sendURL to theString
		(*display dialog sendURL*)
		set the clipboard to sendURL as string
		exit repeat
	end if
end repeat


on menu_click(mList)
	local appName, topMenu, r
	
	-- Validate our input
	if mList's length < 3 then error "Menu list is not long enough"
	
	-- Set these variables for clarity and brevity later on
	set {appName, topMenu} to (items 1 through 2 of mList)
	set r to (items 3 through (mList's length) of mList)
	
	-- WHY NOT DO SOMETHING LIKE THIS FIRST?
	tell application appName to activate
	
	-- This overly-long line calls the menu_recurse function with
	-- two arguments: r, and a reference to the top-level menu
	tell application "System Events" to my menu_click_recurse(r, ((process appName)'s ¬
		(menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))
end menu_click


on menu_click_recurse(mList, parentObject)
	local f, r
	
	-- `f` = first item, `r` = rest of items
	set f to item 1 of mList
	if mList's length > 1 then set r to (items 2 through (mList's length) of mList)
	
	-- either actually click the menu item, or recurse again
	tell application "System Events"
		if mList's length is 1 then
			click parentObject's menu item f
		else
			my menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))
		end if
	end tell
end menu_click_recurse

tell application "MacPass" to activate

menu_click({"MacPass", "Edit", "Find…"}) (* special elipse pasted as 1 character for ....*)
menu_click({"MacPass", "Edit", "Select All"})
delay 0.1
menu_click({"MacPass", "Edit", "Paste"})
delay 0.1
tell application "System Events" to tell process "MacPass" to keystroke return



activate
display alert "AutoFill" message "Choose entry or create new then select - Options:Both fills Username and password on current page -- Username will just fill UN and PW is in the clipboard for 10 secs." buttons {"Both", "Username", "Cancel"} default button "Both"
if button returned of result is "Username" then
	
	delay 0.1
	menu_click({"MacPass", "Item", "Copy Username"})
	delay 0.1
	set infoClipboard to the clipboard
	delay 0.1
	set the clipboard to emptyClip
	
	menu_click({"MacPass", "Item", "Copy Password"})
	delay 0.1
	set pClipboard to the clipboard
	delay 0.1
	set the clipboard to emptyClip
	
	tell application "Safari" to activate
	
	menu_click({"Safari", "Edit", "Select All"})
	set the clipboard to infoClipboard
	menu_click({"Safari", "Edit", "Paste"})
	delay 0.1
	set the clipboard to emptyClip
	set the clipboard to pClipboard
	delay 10
	set the clipboard to emptyClip
	tell application "MacPassAutofill-Prompt" to if it is running then quit
	
	
	
else if button returned of result is "Both" then
	delay 0.1
	menu_click({"MacPass", "Item", "Copy Username"})
	delay 0.1
	set infoClipboard to the clipboard
	delay 0.1
	set the clipboard to emptyClip
	
	menu_click({"MacPass", "Item", "Copy Password"})
	delay 0.1
	set pClipboard to the clipboard
	delay 0.1
	set the clipboard to emptyClip
	
	
	
	
	tell application "Safari" to activate
	delay 0.1
	menu_click({"Safari", "Edit", "Select All"})
	set the clipboard to infoClipboard
	
	menu_click({"Safari", "Edit", "Paste"})
	
	tell application "System Events" to tell process "Safari" to keystroke tab
	delay 0.1
	set the clipboard to pClipboard
	menu_click({"Safari", "Edit", "Paste"})
	delay 0.1
	set the clipboard to emptyClip
	set infoClipboard to emptyClip
	set pClipboard to emptyClip
	tell application "MacPassAutofill-Prompt" to if it is running then quit
	
else if button returned of result is "Cancel" then
	set the clipboard to emptyClip
	set infoClipboard to emptyClip
	set pClipboard to emptyClip
	display dialog "bailing out..."
	tell application "MacPassAutofill-Prompt" to if it is running then quit
	
	
else
	error number -128
	error number -1728
	tell application "MacPassAutofill-Prompt" to if it is running then quit
end if
end run


