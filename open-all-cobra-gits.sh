#!/usr/bin/env bash
#   ---------------------------------------------------------------------------------------------------------
#   --This script will open a new instance of iTerm, cd to the correct directories and open git for each repo
#   ---------------------------------------------------------------------------------------------------------
#
#	-------------------------------------------
#	-- TO RUN
#		-- Create a bash alias, e.g. 
#			-- alias cobragit="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh"
#		-- run $ cobragit

##############################################################################################################
## UPDATE June 2016
## Previously I had an AppleScript that went through and opened up new terminal windows for each command
## At the start of June this stopped working and I couldn't figure out why
## I now use this tool called ttab to open new tabs ->  https://www.npmjs.com/package/ttab
##
## To run multiple commands you need to do eval then wrap all commands in SINGLE quotes
## Put a semicolon between each command
##############################################################################################################
ttab -t "Cobra App"     eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-app; gitx'
ttab -t "Cobra Apps"    eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-apps; gitx'
ttab -t "Cobra Engine"  eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-engine; gitx'
ttab -t "Cobra Games"   eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-games; gitx'
ttab -t "Cobra Tools"   eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-tools; gitx'
ttab -t "Cobra UI"      eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-ui; gitx'