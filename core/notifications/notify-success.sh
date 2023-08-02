date=$(date +%Y-%m-%d' '%H:%M:%S)
echo -e "\n"
curl sms_panel_endpoint --data-urlencode "message=$date - $reason"
echo -e "\n"