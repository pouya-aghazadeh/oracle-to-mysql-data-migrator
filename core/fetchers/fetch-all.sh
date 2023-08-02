ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${ORANGE}Fetching...${NC}"

sqlplus oracle_username/oracle_password@oracle_host_ip:oracle_host_port/oracle_sid @/opt/pool/common/fetch-query.sql > /dev/null

echo -e "${GREEN}All Data Fetched${NC}\n"
