#   ---------------------------------------------------------------------------------------------------------
#   --This script will open a new instance of iTerm, cd to the correct directories and then start our servers
#   ---------------------------------------------------------------------------------------------------------
#
#	-------------------------------------------
#	-- TO RUN
#		-- Create a bash alias, e.g. 
#			-- alias startlp="cd ~/Intrepica/brents_scripts/ && ./start-lp.sh"
#		-- run $ startlp
# More details can be found here
# https://docs.google.com/document/d/1EyNQvTl6BpRCGUbJu2gJliFxWyLTZM_TB79rnKEDetU

osascript <<-eof

	tell application "iTerm"
		activate
		
		set myTerminal to current terminal
		tell myTerminal
		
											
			set localS3Session to (launch session "Hotkey session")
			tell localS3Session
				set name to "Local S3 Asset Server"
				write text "cd /Users/brentmcivor/Intrepica/local-s3"
				write text "http-server -p 7777 --cors"
			end tell
            set cobraWatchAppSession to (launch session "Hotkey session")
            tell cobraWatchAppSession
            set name to "Cobra Watch App"
                write text "cd ~/Intrepica/cobra/gc_component_engine"
                write text "npm install"
                write text "npm run app"
            end tell
			
			set cobraServerSession to (launch session "Hotkey session")
			tell cobraServerSession
				set name to "Cobra Run Server"
				write text "cd ~/Intrepica/cobra/gc_component_engine"
				write text "npm install"
				write text "npm run server"
			end tell
			
			set cobraPassengerSession to (launch session "Hotkey session")
			tell cobraPassengerSession
				set name to "Cobra Passenger"
				write text "cd ~/Intrepica/cobra/gc_component_engine"
				write text "passenger start"
			end tell
			set cobraGitSession to (launch session "Hotkey session")
			tell cobraGitSession
				set name to "Cobra Git"
				write text "cd ~/Intrepica/cobra/gc_component_engine"
				write text "gitx"
			end tell
								
		end tell
	end tell
eof