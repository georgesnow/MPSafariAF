# MPSafariAF
Applescript that autofills from MacPass into Safari based on the front most tab

![](MPSafariAF-demo.gif)

This app provides the ability to grab credentials from your macpass (keepass database) based on URL of the front most tab in Safari. (beware it operates like Autotype so make sure you have the proper text field selected)


You can attempt to fill both fields or just Username which will paste the username and allow you to paste the password (hardcoded at 10secs to clipboard then clears) for pages that are split.


The app then quits and is re-launchable...

i recommend using https://red-sweater.com/fastscripts/
aamazing app point the app to the folder your have the script and assign global keyboard shortcut and off you go (review the importants notes below)


that's it...

Important notes:

MacPass needs to be open and unlocked Whatever tab is most front in Safari is the URL it will grab. Must select the proper text field before firing this thing off

the script clears the search box and password and username fields before pasting them. 
also if you don't unlock your macpass the URL is kept in the clipboard until you choose Both, Username, or Cancel
so you can unlock your database and paste into the macpass=>select entry=>then click desire mode of Both or Username


if you use the release version beware:
You have to setup the Privacy settings in System Preferences. As you have to allow the app to control other apps etc...and to clear them you need some understanding tccutil.
it required me to modify the info.plist to get it work, which there is little to no documentation on. so it took alot testing to figureout the right combo. thats a note if you trying to make an app that controls other apps. you can look at the info.plist of the release version.

I recommend after launching you set it so the icon stays in your dock and place next to Safari, but to each their own.

I express no warranty i gave credit where due if i used code from somewhere. this is as is and for users to test and mess around with.
