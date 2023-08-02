# Data Migration Automation From Oracle To MySQL



## Getting started

To use this script you need that oracle instant client has been installed on remote OS.

After installing, you sould set below variables inside system environment or crontab environment to set some settings

```
ORACLE_HOME=/opt/instantclient_<version>/
PATH=/opt/instantclient_<version>:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
NLS_LANG=.AL32UTF8
NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
LD_LIBRARY_PATH=/opt/instantclient_<version>:$LD_LIBRARY_PATH
```

## Oracle Instant Client Installation

Go to `https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html`\
Install `Basic Package`, `SQL*Plus Package` and `Tools Package` in path `/opt/instantclient_<version>`

## Settings of notifications

you can set your phone number in this path to get notificiations :

`core/notifications/notify-error.sh`\
`core/notifications/notify-success.sh`

## Manual Usage

To Use Main Three Actions:\
1- `Fetch` : to fetch data from rmto db and save seperately inside modules like `/opt/pool/table_name/export/`\
2- `Migrate` : to process/refactor fetched data and upload to destination db `basic`\
3- `Update` : to replace migrated data with previous data in `basic`

#### You can use below command :
`-i` for non-interactive mode for jobs
``` sh
/opt/pool/core/run.sh <-i> <fetch/migrate/update|all> <table_name|all>
```

## Final Step [Jobs]

``` sh
0 * * * * /opt/pool/core/connections/remote-connect.sh >/dev/null 2>&1
5 * * * * /opt/pool/core/run.sh -i all table_name > /opt/pool/logs/td-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
58 * * * * /opt/pool/core/connections/remote-disconnect.sh >/dev/null 2>&1
```


create index waybills_waybill_serial_waybill_number_index
	on basic.waybills (waybill_serial, waybill_number);


```
