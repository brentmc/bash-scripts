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
#           -- alias tagcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -tag"
#           -- alias deletetagcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -deleteTag"
#           -- alias checkoutcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -checkout"
#           -- alias npminstallcobra="cd ~/Intrepica/brents_scripts/ && ./open-all-cobra-gits.sh -npmInstall"
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


cobraFolder="/Users/brentmcivor/Intrepica/cobra/"
app="cobra-app"
apps="cobra-apps"
engine="cobra-engine"
exercise="cobra-exercise"
games="cobra-games"
lpAPI="cobra-lp-api"
tools="cobra-tools"
ui="cobra-ui"
reposAr=($app $apps $engine $exercise $games $lpAPI $tools $ui)

#########################################################################
# Opens all repos in a new tab then runs the given command
#########################################################################
function run {
	command="$1"

	for i in "${reposAr[@]}"
	do
		repoFolder=$i
		tabTitle=${i#'cobra-'} #strips 'cobra-' from the start of the String

		completeCommand='cd '$cobraFolder$repoFolder'; '"$command"

		#echo $completeCommand
		ttab -t $tabTitle eval $completeCommand
	done
}


#########################################################################
# Pulls down master for all repos
#
# To protect from accidentally pulling down over any uncommitted changes
# we confirm the query
#########################################################################
function runPull {
	run 'git-smart-pull;'
}

function confirmPull {
	echo "This will pull down over existing code."
	echo "Are you sure you want to do this?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runPull
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
function runPush {
	run 'git-smart-pull; git push origin master;'
}

function confirmPush {
	echo "This will pull down over existing code. Then push to remote master."
	echo "Are you sure you want to do this?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runPush
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}

#########################################################################
# Lint all repos at once
#########################################################################
function runLint {
	run 'eslint ./*;'
}

#########################################################################
# Runs npm install on all repos at once
#########################################################################
function runNpmInstall {
	run 'npm install;'
}


#########################################################################
# Tag the same version and commit message on all repos at once
# You need to wrap the message in double quotes otherwise it loses everything
# after the first space
#########################################################################
function runTag {
	tag="$1"
	commitMsg="$2"
	echo $tag
	echo $commitMsg
	run 'git tag -a '"$tag"' -m '\""$commitMsg"\"'; git push --tags;'
}

function createTag {
	echo "This will create and push a tag on all repos at once."
	echo "Enter version number. (e.g. 1.2.3-ios)"
	read versionNum
	tag="sw/v"$versionNum #so we don't have to add the sightwords and ver. prefix

	echo "Enter commit message."
	read commitMsg

	echo "Tag:" $tag "Message:" $commitMsg
	echo "Is this correct?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runTag $tag "$commitMsg"
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}

#########################################################################
# Deletes a tag locally and remotely from all repos
#########################################################################
function runDeleteTag {
	tag="$1"
	run 'git tag -d '$tag'; git push origin :refs/tags/'$tag
}

function deleteTag {
	echo "This will delete a tag both locally and remotely from all repos;"
	echo "Which tag do you want to delete? (e.g. 1.2.3-ios)"
	read versionNum
	tag="sw/v"$versionNum #so we don't have to add the sightwords and ver. prefix

	echo "Delete "$tag" locally and remotely from all repos?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runDeleteTag $tag
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}


#########################################################################
# Create a branch (locally and remotely) with the same name on all repos
#########################################################################
function runBranch {
	completeBranch="$1"
	run 'git checkout -b '$completeBranch'; git push origin '$completeBranch
}

function createBranch {
	echo "This will create a feature branch on all repos at once."
	echo "Enter branch name. (e.g. prototypes)"
	read branch
	completeBranch='feature/'$branch # so we don't have to manually add feature/ prefix

	echo "Branch: "$completeBranch" will be created locally and remotely"
	echo "Is this correct?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runBranch $completeBranch
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}

#########################################################################
# Delete a branch (locally and remotely) with the same name on all repos
#########################################################################
function runDeleteBranch {
	completeBranch="$1"
	run 'git branch -d '$completeBranch'; git push origin :'$completeBranch
}

function deleteBranch {
	echo "This will delete a feature branch on all repos at once."
	echo "Enter branch name. (e.g. prototypes)"
	read branch
	completeBranch='feature/'$branch # so we don't have to manually add feature/ prefix

	echo "Branch: "$completeBranch" will be deleted locally and remotely"
	echo "Is this correct?"
	select yn in "Yes" "No"; do
	    case $yn in
	        "Yes" )
	            runDeleteBranch $completeBranch
	            break;;
	        "No" )
	            exit;;
	    esac
	done
}


#########################################################################
# Use these checkout functions to quickly get all repos to a particular
# release tag or back to master
#########################################################################
function runCheckout {
	branchToCheckout="$1"
	run 'git checkout '$branchToCheckout';'
}

function checkoutTag {
	echo "Which tag do you want to checkout? (e.g. 1.2.3-ios)"
	read tag
	runCheckout 'tags/sw/v'$tag
}

function checkoutBranch {
	echo "Which FEATURE branch do you want to checkout? (e.g. prototypes)"
	read branch
	runCheckout 'feature/'$branch
}

function queryCheckout {
	echo "This will open every Cobra repo and check out a certain commit."
	echo "What do you want to check out?"
	select branch in "Master" "Branch" "Tagged Commit" "Exit"; do
		case $branch in
			"Master" )
				runCheckout "master"
				break;;
			"Branch" )
				checkoutBranch
				break;;
			"Tagged Commit" )
				checkoutTag
				break;;
			"Exit" )
				exit;;
		esac
	done
}

#########################################################################
# This is the first stuff that happens
# Call this file then pass through an argument
# ./open-all-cobra-gits.sh -open (opens each repo in an iTerm tab)
# ./open-all-cobra-gits.sh -pull (opens then pulls down)
# ./open-all-cobra-gits.sh -push (opens, pulls down then pushes up)
# ./open-all-cobra-gits.sh -eslint (opens, then checks eslint)
# ./open-all-cobra-gits.sh -tag (opens, then tags all repos with given tag and message)
# ./open-all-cobra-gits.sh -branch (opens, then creates a branch)
# ./open-all-cobra-gits.sh -checkout (opens, then checks out the given tag)
# ./open-all-cobra-gits.sh -npminstall (opens, then runs npm install)
#########################################################################
key="$1"
case $key in
	-open)
	run
	;;
	-eslint)
	runLint
	;;
	-pull)
	confirmPull
	;;
	-push)
	confirmPush
	;;
	-tag)
	createTag
	;;
	-deleteTag)
	deleteTag
	;;
	-branch)
	createBranch
	;;
	-deleteBranch)
	deleteBranch
	;;
	-checkout)
	queryCheckout
	;;
	-npmInstall)
	runNpmInstall
	;;
esac