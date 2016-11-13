#!/usr/bin/env bash

cobra='~/Intrepica/cobra/cobra-apps'
lp_webapp='~/Intrepica/playbooks/app_development_box'

#########################################################################
# cobra code
#########################################################################
function startCobra {
	## Watches the codebase and rebuilds on changes
	ttab -t "Cobra Watch Apps"  eval 'cd '$cobra'; npm install; npm run browserStage'

	## Serves the node app
	ttab -t "Cobra Run Server"  eval 'cd '$cobra'; npm install; npm run server'
}

#########################################################################
# lp-webapp/vagrant code
#########################################################################
function startVagrant {
	command='cd '$lp_webapp'; vagrant up web;'
	ttab -t "Web Vagrant" eval $command

	command='cd '$lp_webapp'; vagrant up node;'
	ttab -t "Node Vagrant" eval $command
}

function stopVagrant {
	# Running vagrant halt will kill both instances
	command='cd '$lp_webapp'; vagrant halt;'
	ttab -t "Stop Vagrant" eval $command
}

#########################################################################
# Launch
#########################################################################
key="$1"
case $key in
	-startJustCobra)
	startCobra
	;;

	--startCobraAndVagrant)
	startCobra
	startVagrant
	;;

	-startVagrant)
	startVagrant
	;;

	-stopVagrant)
	stopVagrant
	;;
esac