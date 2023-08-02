ORANGE='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "\n${ORANGE}Refactoring table_name Data... ${NC}\n"

if [ -e /opt/pool/table_name/exports/table_name_temp.csv ]; then
  rm /opt/pool/table_name/exports/table_name_temp.csv
fi

cp -i /opt/pool/table_name/exports/table_name_temp_raw.csv /opt/pool/table_name/exports/table_name_temp.csv


sed -i '1d' /opt/pool/table_name/exports/table_name_temp.csv
sed -i '1d' /opt/pool/table_name/exports/table_name_temp.csv
sed -i '$d' /opt/pool/table_name/exports/table_name_temp.csv
sed -i '$d' /opt/pool/table_name/exports/table_name_temp.csv
sed -i '$d' /opt/pool/table_name/exports/table_name_temp.csv
sed -i 's/\"//g' /opt/pool/table_name/exports/table_name_temp.csv
sed -i ':a;N;$!ba;s/\r\n//g' /opt/pool/table_name/exports/table_name_temp.csv

echo -e "${ORANGE}Executing table_name Pre-Migration Query... ${NC}\n"

/usr/bin/mysql -h mysql_host_ip -P mysql_host_port -L -u mysql_username -p'mysql_password' mysql_database < /opt/pool/table_name/pre-migration-query.sql

echo -e "${ORANGE}Migrating table_name Data... ${NC}\n"
    
/usr/bin/mysqlimport --fields-terminated-by=~ -h mysql_host_ip -P mysql_host_port -L -u mysql_username -p'mysql_password' mysql_database /opt/pool/table_name/exports/table_name_temp.csv

echo -e "${GREEN}table_name Data Migrated${NC}\n"

exit 1
