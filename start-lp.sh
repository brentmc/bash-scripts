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
		
			set vagrantStartupSession to (launch session "Hotkey session")
			tell vagrantStartupSession
				set name to "Vagrant Up"
				write text "cd ~/Intrepica/lp_webapp/"
				write text "vagrant up"
			end tell
						
			set lpWebAppSession to (launch session "Hotkey session")
			tell lpWebAppSession
				set name to "LP WebApp Rails"
				write text "cd ~/Intrepica/lp_webapp/"
				write text "bundle exec rails s -p 4000"
			end tell
					
			set localFileServerSession to (launch session "Hotkey session")
			tell localFileServerSession
				set name to "Local Assets Server"
				write text "cd /Users/brentmcivor/Intrepica/local-s3"
				write text "http-server -p 7777 --cors"
			end tell
			
			set cobraWatchSession to (launch session "Hotkey session")
			tell cobraWatchSession
				set name to "Cobra Watch"
				write text "cd ~/Intrepica/cobra/gc_cobra_engine"
				write text "npm install"
				write text "npm run watch"
			end tell
			
			set cobraServerSession to (launch session "Hotkey session")
			tell cobraServerSession
				set name to "Cobra Run Server"
				write text "cd ~/Intrepica/cobra/gc_cobra_engine"
				write text "npm install"
				write text "npm run server"
			end tell
			
			set flash1point5Session to (launch session "Hotkey session")
			tell flash1point5Session
				set name to "Flash 1.5"
				write text "cd /Users/brentmcivor/Intrepica/development/Application"
			end tell
			
			set flash1point7Session to (launch session "Hotkey session")
			tell flash1point7Session
				set name to "Flash 1.7"
				write text "cd /Users/brentmcivor/Intrepica/literacyplanet/src"
			end tell
			
			set lpWebAppSession to (launch session "Hotkey session")
			tell lpWebAppSession
				set name to "LP WebApp Git"
				write text "cd ~/Intrepica/lp_webapp/"
			end tell
			
			set cobraGitSession to (launch session "Hotkey session")
			tell cobraGitSession
				set name to "Cobra Git"
				write text "cd ~/Intrepica/cobra/gc_cobra_engine"
			end tell
								
		end tell
	end tell
eof