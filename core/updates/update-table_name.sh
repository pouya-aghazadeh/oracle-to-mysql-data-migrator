ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${ORANGE}Updating table_name With Update Query... ${NC}\n"

/usr/bin/mysql -h mysql_host_ip -P mysql_host_port -L -u mysql_username -p'mysql_password' mysql_database < /opt/pool/table_name/update-query.sql

echo -e "${GREEN}table_name Updated Successfully${NC}\n"

exit 1
