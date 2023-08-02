ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${ORANGE}Checking Health Of Fetching Data From DB...${NC}"

sqlplus oracle_username/oracle_password@oracle_host_ip:oracle_host_port/oracle_sid << EOF
      whenever sqlerror exit sql.sqlcode;
      select 1 from dual;
      exit;
EOF
ERR_CODE=$?
if [[ 0 != "${ERR_CODE}" ]] ; then
  reason="error in data fetch"
  export reason && /opt/pool/core/notifications/notify-error.sh > /dev/null
  echo -e "${RED}Error SMS Sent! ${NC}- $reason"
  exit 0
else
  exit 1
fi
