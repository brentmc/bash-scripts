#!/usr/bin/env bash
#   ---------------------------------------------------------------------------------------------------------
#   --This script will open a new instance of iTerm, cd to the correct directories and open git for each repo
#   ---------------------------------------------------------------------------------------------------------
#
#	-------------------------------------------
#	-- TO RUN
#		-- Create a bash alias, e.g. 
#			-- alias opencobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -open"
#           -- alias pullobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -pull"
#           -- alias pushcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -push"
#           -- alias eslintcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -eslint"
#		-- run $ opencobra

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
exercise='cobra-exercise'
games='cobra-games'
lpAPI='cobra-lp-api'
tools='cobra-tools'
ui='cobra-ui'
reposAr=($app $apps $engine $exercise $games $lpAPI $tools $ui)

function openGitTower {
	command='gittower '$cobraFolder$games
	ttab -t 'GitTower' eval $command
}
#########################################################################
# Opens all repos in a new tab then opens gitx
# If you pass through true it will also run
# $git-smart-pull for each repo to update everything
#########################################################################
function openAll {
  needsToPullDown=$1
  needsToPush=$2
  needsToLint=$3

	## openGitTower No longer want to open GitTower automatically

	for i in "${reposAr[@]}"
	do
		repoFolder=$i
		tabTitle=${i#'cobra-'} #strips "cobra-" from the start of the String

		#Going to try out GitTower now instead of opening up a heap of gitx windows
		#command='cd '$cobraFolder$repoFolder'; gitx;'
		command='cd '$cobraFolder$repoFolder';'

		if $needsToPullDown
		then
			command=$command' git-smart-pull;'
		fi

		if $needsToPush
		then
			command=$command' git push origin master;'
		fi

		if $needsToLint
		then
			echo 'lint'
			command=$command' eslint ./*;'
		fi

		#echo $command
		ttab -t $tabTitle eval $command
	done
}

#########################################################################
# To protect from accidentally pulling down over any uncommitted changes
# we confirm the query
#########################################################################
function confirmPull {
	echo "This will pull down over existing code."
	echo "Are you sure you want to do this?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            openAll true false false
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}

#########################################################################
# To protect from accidentally pulling down over any uncommitted changes
# or pushing to origin master before we are ready,
# we confirm the query
#########################################################################
function confirmPush {
	echo "This will pull down over existing code. Then push to remote master."
	echo "Are you sure you want to do this?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            openAll true true false
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}


#########################################################################
# This is the first stuff that happens
# Call this file then pass through an argument
# ./open-all-cobra-gits.sh -open (opens GitTower and each repo in an iTerm tab)
# ./open-all-cobra-gits.sh -pull (opens then pulls down)
# ./open-all-cobra-gits.sh -push (opens, pulls down then pushes up)
# ./open-all-cobra-gits.sh -eslint (opens, then checks eslint)
#########################################################################
key="$1"
case $key in
	-open)
	openAll false false false
	;;
	-eslint)
	openAll false false true
	;;
	-pull)
	confirmPull
	;;
	-push)
	confirmPush
	;;
esac