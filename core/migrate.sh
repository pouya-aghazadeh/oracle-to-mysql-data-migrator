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

if [ $point == "all" ]; then
	/opt/pool/core/migrations/migrate-table_name.sh

# ================ specific operations ==================
elif [ $point == "table_name" ]; then
	/opt/pool/core/migrations/migrate-drivers.sh
fi
