#!/usr/bin/env bash
#   ---------------------------------------------------------------------------------------------------------
#   --This script will open a new instance of iTerm, cd to the correct directories and open git for each repo
#   ---------------------------------------------------------------------------------------------------------
#
#	-------------------------------------------
#	-- TO RUN
#		-- Create a bash alias, e.g. 
#			-- alias cobragit="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh"
#		-- run $ startlp
# More details can be found here

osascript <<-eof

	tell application "iTerm"
		activate
		
		set myTerminal to current terminal
		tell myTerminal

			set cobraAppSession to (launch session "Hotkey session")
			tell cobraAppSession
				set name to "Cobra App"
				write text "cd /Users/brentmcivor/Intrepica/cobra/cobra-app"
				write text "gitx"
			end tell

			set cobraAppsSession to (launch session "Hotkey session")
			tell cobraAppsSession
				set name to "Cobra Apps"
				write text "cd /Users/brentmcivor/Intrepica/cobra/cobra-apps"
				write text "gitx"
			end tell

			set cobraEngineSession to (launch session "Hotkey session")
			tell cobraEngineSession
				set name to "Cobra Engine"
				write text "cd /Users/brentmcivor/Intrepica/cobra/cobra-engine"
				write text "gitx"
			end tell

			set cobraToolsSession to (launch session "Hotkey session")
			tell cobraToolsSession
				set name to "Cobra Tools"
				write text "cd /Users/brentmcivor/Intrepica/cobra/cobra-tools"
				write text "gitx"
			end tell

            set cobraUISession to (launch session "Hotkey session")
            tell cobraUISession
				set name to "Cobra UI"
				write text "cd /Users/brentmcivor/Intrepica/cobra/cobra-ui"
				write text "gitx"
			end tell

		end tell
	end tell
eof