#!/usr/bin/env bash
#   ---------------------------------------------------------------------------------------------------------
#   --This script will open a new instance of iTerm, cd to the correct directories and then start our servers
#   ---------------------------------------------------------------------------------------------------------
#
#	-------------------------------------------
#	-- TO RUN
#		-- Create a bash alias, e.g. 
#			-- alias startlp="cd ~/Intrepica/brents_scripts/ && ./start-lp.sh"
#		-- run $ startcobra

##############################################################################################################
## UPDATE June 2016
## Previously I had an AppleScript that went through and opened up new terminal windows for each command
## At the start of June this stopped working and I couldn't figure out why
## I now use this tool called ttab to open new tabs ->  https://www.npmjs.com/package/ttab
##
## To run multiple commands you need to do eval then wrap all commands in SINGLE quotes
## Put a semicolon between each command
##############################################################################################################

##############################################################################################################
## UPDATE Sep 2016
## Just use the updated start-lp.sh
##############################################################################################################

## Watches the codebase and rebuilds on changes
#ttab -t "Cobra Watch Apps"  eval 'cd ~/Intrepica/cobra/cobra-apps; npm install; npm run browserDev'

## Serves the node app
#ttab -t "Cobra Run Server"  eval 'cd ~/Intrepica/cobra/cobra-apps; npm install; npm run server'


########################################################
## Starts Passenger for reverse proxy, load balance, auto restart etc
########################################################
## 31 May 2016 - Dan disabled Passenger because with cors disabled
## via the chrome cors plugin we no longer need https

##set cobraPassengerSession to (launch session "Hotkey session")
##tell cobraPassengerSession
##	set name to "Cobra Passenger"
##	write text "cd ~/Intrepica/cobra/gc_component_engine"
##	write text "passenger start"
##end tell