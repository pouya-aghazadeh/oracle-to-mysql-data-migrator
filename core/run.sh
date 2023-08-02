#! /bin/bash

ORANGE='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

action_code=0
point_code=0

interaction=1
while getopts ":i" option; do
   case $option in
      i) interaction=0;;
     \?) echo "Error: Invalid option"
         exit;;
   esac
done
if [ $OPTIND -eq 2 ]; then
	if [ -z "$2" ]; then
  	action="all"
	else
  	action="$2"
	fi
	
	if [ -z "$3" ]; then
  	point="all"
	else
  	point="$3"
	fi
else
	if [ -z "$1" ]; then
  	action="all"
	else
  	action="$1"
	fi
	
	if [ -z "$2" ]; then
  	point="all"
	else
  	point="$2"
	fi
fi




echo -e ""

if [ $action == "all" ]; then
	action_code=1
	echo -e "${ORANGE}Actions${NC}: ${GREEN}All${NC} [ ${CYAN}Fetch${NC} / ${CYAN}Migrate${NC} / ${CYAN}Update${NC} ]"
elif [ $action == "fetch" ]; then
	action_code=2
	echo -e "${ORANGE}Action${NC}: ${GREEN}Fetching${NC}"
elif [ $action == "migrate" ]; then
	action_code=3
	echo -e "${ORANGE}Action${NC}: ${GREEN}Migrating${NC}"
elif [ $action == "update" ]; then
	action_code=4
	echo -e "${ORANGE}Action${NC}: ${GREEN}Updating${NC}"
else
	echo -e "${ORANGE}Action${NC}: ${RED}Undefined${NC}\n"
	exit -1
fi

echo -e ""


if [ $point == "all" ]; then
	point_code=1
	echo -e "${ORANGE}Points${NC}: ${GREEN}All${NC} [ ${CYAN}table_name${NC} ]"
elif [ $point == "table_name" ]; then
	point_code=2
	echo -e "${ORANGE}Point${NC}: ${GREEN}Drivers${NC}"
else
	echo -e "${ORANGE}Point${NC}: ${RED}Undefined${NC}\n"
	exit -2
fi

echo -e ""

if [ $interaction == 1 ]; then
	read -t 10 -r -p $'\033[0;34mAre you sure?\033[0m [y/N] ' response
else
	response="y"
fi



echo -e ""
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	if [ $action_code == 1 ]; then
		/opt/pool/core/fetch.sh $point
		HEALTHY=$?
		if [ "${HEALTHY}" == 1 ] ; then
			/opt/pool/core/migrate.sh $point
			HEALTHY=$?
			if [ "${HEALTHY}" == 1 ] ; then
				/opt/pool/core/update.sh $point
				HEALTHY=$?
				if [ "${HEALTHY}" != 1 ] ; then
					echo -e "${RED}An Error Occurred While Updating Data!${NC}"
					exit -1
				fi
			else
				echo -e "${RED}An Error Occurred While Migrating Data!${NC}"
				exit -1
			fi
		else
			echo -e "${RED}An Error Occurred While Fetching Data!${NC}"
			exit -1
		fi
	elif [ $action_code == 2 ]; then
		/opt/pool/core/fetch.sh $point
		HEALTHY=$?
		if [ "${HEALTHY}" != 1 ] ; then
			echo -e "${RED}An Error Occurred While Fetching Data!${NC}"
			exit -1
		fi
	elif [ $action_code == 3 ]; then
  	/opt/pool/core/migrate.sh $point
  	HEALTHY=$?
		if [ "${HEALTHY}" != 1 ] ; then
			echo -e "${RED}An Error Occurred While Migrating Data!${NC}"
			exit -1
		fi
  elif [ $action_code == 4 ]; then
  	/opt/pool/core/update.sh $point
  	HEALTHY=$?
		if [ "${HEALTHY}" != 1 ] ; then
			echo -e "${RED}An Error Occurred While Updating Data!${NC}"
			exit -1
		fi
	fi
	echo -e "${GREEN}---Done---${NC}"
	exit 1
	
elif [ -z $response ]; then
  echo -e "\n${RED}Operation Timed Out! ${NC}"
else
	echo -e "${RED}Operation Canceled ${NC}"
fi
echo -e ""

