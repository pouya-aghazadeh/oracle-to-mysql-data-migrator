ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ -z "$1" ]; then
  point="all"
else
  point="$1"
fi

/opt/pool/core/connections/fetching-check.sh > /dev/null
HEALTHY=$?
if [ "${HEALTHY}" == 1 ] ; then
  # ================== all operations ====================
	if [ $point == "all" ]; then
	
		/opt/pool/core/fetchers/fetch-all.sh
		
		/opt/pool/core/health-checks/health-check-table_name.sh
		HEALTHY=$?
		if [ "${HEALTHY}" != 1 ] ; then
  		echo -e "${RED}Fetched table_name Data Is Damaged${NC}"
  		exit -1
		fi

  # ================ specific operations ==================
	elif [ $point == "table_name" ]; then
		/opt/pool/core/fetchers/fetch-table_name.sh
		/opt/pool/core/health-checks/health-check-table_name.sh
		HEALTHY=$?
		if [ "${HEALTHY}" != 1 ] ; then
  		echo -e "${RED}Fetched table_name Data Is Damaged${NC}"
  		exit -1
		fi	
	fi
	exit 1
else
	exit -1
fi
