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
#ttab -t "Cobra App"     eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-app; gitx'
#ttab -t "Cobra Apps"    eval 'cd /Users/brentmcivor/Intrepica/cobra/cobra-apps; gitx'


cobraFolder='/Users/brentmcivor/Intrepica/cobra/'
app='cobra-app'
apps='cobra-apps'
engine='cobra-engine'
games='cobra-games'
lpAPI='cobra-lp-api'
tools='cobra-tools'
ui='cobra-ui'
reposAr=($app $apps $engine $games $lpAPI $tools $ui)

######################################################
# Opens all repos in a new tab then opens gitx
# If you pass through true it will also run
# $git-smart-pull for each repo to update everything
######################################################
function openAll {
  needsToPullDown=$1

	for i in "${reposAr[@]}"
	do
		repoFolder=$i
		tabTitle=$i

		command='cd '$cobraFolder$repoFolder'; gitx;'

		if $needsToPullDown
		then
			command=$command' git-smart-pull'
		fi

		#echo $command
		ttab -t $tabTitle eval $command
	done
}

######################################################
# To protect from accidentally pulling down over any
# uncommitted changes we confirm the query
######################################################
function confirmUpdate {
	echo "This will pull down over existing code. Are you sure you want to do this?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            openAll true
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}

######################################################
# First question that kicks everything off
# You can choose to open up gitx for each repo
# or open up gitx for each AND pull down all changes
######################################################
function firstQuestion {
	echo "Do you want to pull down the latest changes?"
	select yn in "Yes" "No" "Exit"; do
	    case $yn in
	        "Yes" )
	            confirmUpdate
	            break;;
	        "No" )
	            openAll false
	            break;;
	        "Exit" )
	            exit;;
	    esac
	done
}

firstQuestion