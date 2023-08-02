table_name_min_size=200

ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${ORANGE}Checking Fetched Data...${NC}"
filesize=$(wc -c /opt/pool/table_name/exports/table_name_temp_raw.csv | awk '{print $1}')
mb=$( printf "%.0f" $(/usr/bin/bc <<<"scale=6; $filesize / 1048576"))
if [[ $mb -lt $table_name_min_size ]]
then
     echo -e "${RED}table_name data is smaller than normal${NC}"
     reason="a problem in fetched data detected"
     export reason && /opt/pool/core/notifications/notify-error.sh > /dev/null
     echo -e "${RED}Error SMS Sent! ${NC}- $reason"
     exit 0  
else
     echo -e "${CYAN}table_name${NC} data is : ${GREEN}OK${NC} \n"
fi
exit 1
