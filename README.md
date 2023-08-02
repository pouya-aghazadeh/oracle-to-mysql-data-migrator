# RMTO Sync Automation



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
1- `Fetch` : to fetch data from rmto db and save seperately inside modules like `/opt/pool/drivers/export/`\
2- `Migrate` : to process/refactor fetched data and upload to destination db `basic`\
3- `Update` : to replace migrated data with previous data in `basic`

#### You can use below command :
`-i` for non-interactive mode for jobs
``` sh
/opt/pool/core/run.sh <-i> <fetch/migrate/update|all> <drivers/fleets/waybills/technical-diagnosis/companies/loaders|all>
```

## Final Step [Jobs]

``` sh
0 * * * * /opt/pool/core/connections/remote-connect.sh >/dev/null 2>&1
5 * * * * /opt/pool/core/run.sh -i all technical-diagnosis > /opt/pool/logs/td-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
10 */4 * * * /opt/pool/core/run.sh -i all drivers > /opt/pool/logs/d-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
25 */4 * * * /opt/pool/core/run.sh -i all fleets > /opt/pool/logs/f-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
35 */3 * * * /opt/pool/core/run.sh -i all waybills > /opt/pool/logs/w-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
45 0 */5 * * /opt/pool/core/run.sh -i all companies > /opt/pool/logs/c-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
50 0 */5 * * /opt/pool/core/run.sh -i all loaders > /opt/pool/logs/l-`date +\%Y-\%m-\%d-\%H:\%M:\%S`.log
58 * * * * /opt/pool/core/connections/remote-disconnect.sh >/dev/null 2>&1
```

## Destination DB Structure

``` sql
create table basic.companies
(
	code varchar(100) null,
	name varchar(255) null,
	national_code varchar(100) null,
	activity_type_code varchar(10) null,
	license_expire_date varchar(100) null,
	ownership_type varchar(100) null,
	city_place_code varchar(100) null,
	address text null,
	tell varchar(100) null,
	email varchar(100) null,
	class_number varchar(100) null,
	status varchar(100) null,
	company_type_code varchar(100) null,
	company_owner_kind_code varchar(100) null,
	transport_kind_code varchar(100) null,
	vanetbar varchar(100) null,
	criteria_place_code varchar(100) null,
	generality_kind varchar(100) null,
	responsibility_code varchar(100) null,
	id int auto_increment
		primary key
);

create table basic.drivers
(
	passport_number varchar(255) null,
	driver_class varchar(255) null,
	activity_scope varchar(255) null,
	license_type varchar(255) null,
	expire_date varchar(255) null,
	expires varchar(255) null,
	document_number varchar(255) null,
	driver_code varchar(255) null,
	driver_type varchar(255) null,
	driver_type_code varchar(255) null,
	scope varchar(255) null,
	national_id varchar(255) null,
	first_name varchar(255) null,
	last_name varchar(255) null,
	father_name varchar(255) null,
	birthdate varchar(255) null,
	birth_certificate_number varchar(255) null,
	nationality varchar(255) null,
	country_code varchar(255) null,
	birth_city_code varchar(255) null,
	birth_certificate_issue_place varchar(255) null,
	address text null,
	tel varchar(255) null,
	address_city_code varchar(255) null,
	living_city varchar(255) null,
	living_city_code varchar(255) null,
	driving_license_type varchar(255) null,
	driving_license_number varchar(255) null,
	driving_license_city_code varchar(255) null,
	driving_license_issue_place varchar(255) null,
	comments text null,
	insurance_number varchar(255) null,
	branch varchar(255) null,
	insurance varchar(255) null,
	education varchar(255) null,
	education_code varchar(255) null,
	statistician varchar(255) null,
	requester varchar(255) null,
	smart_card_number varchar(255) null,
	smart_card_serial varchar(255) null,
	state_code varchar(255) null,
	state_title varchar(255) null,
	state_title_code varchar(255) null,
	send_to_state varchar(255) null,
	receive_place varchar(255) null,
	receive_place_code varchar(255) null,
	is_active_code varchar(255) null,
	is_active varchar(255) null,
	issue_date varchar(255) null,
	mobile varchar(255) null,
	insurance_name varchar(255) null,
	insurance_type varchar(255) null,
	renew_status varchar(255) null,
	health_card_status varchar(255) null,
	verify_status varchar(255) null,
	driving_license_date varchar(255) null,
	driving_license_expire_date varchar(255) null,
	created_at varchar(255) null,
	address_state_code varchar(255) null,
	id int auto_increment
		primary key
);

create index drivers_mobile_index
	on basic.drivers (mobile);

create index drivers_national_id_index
	on basic.drivers (national_id);

create table basic.fleets
(
	card_number varchar(10) null,
	document_number varchar(15) null,
	vin varchar(20) null,
	plaque_type varchar(5) null,
	is_active tinyint null,
	made_year int(5) null,
	`system` int(5) null,
	type int(5) null,
	qty int(5) null,
	axis int(2) null,
	created_at datetime null,
	fleet_type int(5) null,
	state_code int(10) null,
	plaque_city_code int(10) null,
	plaque_number varchar(10) null,
	plaque_serial int(4) null,
	plaque_color varchar(5) null,
	loader_type_code int(5) null,
	made_country_code int(5) null,
	status int(5) null,
	year_type varchar(5) null,
	loader_link_type varchar(5) null,
	company_ownership_type varchar(5) null,
	ownership_type varchar(5) null,
	scope varchar(5) null,
	id int auto_increment
		primary key
);

create index fleets_card_number_index
	on basic.fleets (card_number);

create index fleets_document_number_index
	on basic.fleets (document_number);

create index fleets_loader_type_code_index
	on basic.fleets (loader_type_code);

create index fleets_plaque_number_plaque_serial_index
	on basic.fleets (plaque_number, plaque_serial);

create index fleets_vin_index
	on basic.fleets (vin);

create table basic.loaders
(
	id int auto_increment
		primary key,
	loader_code int null,
	title varchar(255) null,
	loader_type varchar(255) null
);

create index loaders_loader_code_index
	on basic.loaders (loader_code);

create table basic.structures
(
	id int auto_increment
		primary key,
	class enum('driver', 'fleet', 'waybill', 'fdl') not null,
	method varchar(255) null,
	`schema` longtext collate utf8mb4_bin not null,
	is_active tinyint(1) default 1 not null,
	constraint `schema`
		check (json_valid(`schema`))
);

create table basic.technical_diagnosis
(
	document_number int null,
	vin varchar(100) null,
	fleet_type int null,
	so2_level varchar(50) null,
	expire_date int null,
	fleet_type_title varchar(100) null,
	id int auto_increment
		primary key
);

create index technical_diagnosis_temp_document_number_index
	on basic.technical_diagnosis (document_number);

create index technical_diagnosis_temp_vin_index
	on basic.technical_diagnosis (vin);

create table basic.waybills
(
	waybill_serial varchar(255) null,
	waybill_number varchar(255) null,
	issue_date datetime null,
	carrier_company_code varchar(255) null,
	tracking_code varchar(255) null,
	origin varchar(255) null,
	destination varchar(255) null,
	first_driver_national_id varchar(255) null,
	second_driver_national_id varchar(255) null,
	plaque_number varchar(255) null,
	smart_card_number varchar(255) null,
	packing_type varchar(255) null,
	good_value varchar(255) null,
	weight varchar(255) null,
	fare varchar(255) null,
	driver_commission varchar(255) null,
	insurance_cost varchar(255) null,
	product_code varchar(255) null,
	loader_code varchar(255) null,
	tax varchar(255) null,
	terminal_cost varchar(255) null,
	total_cost varchar(255) null,
	cmp_code varchar(255) null,
	plaque_serial varchar(255) null,
	document_number_t varchar(255) null,
	document_number_d1 varchar(255) null,
	waste varchar(255) null,
	plaque_placement_place varchar(255) null,
	register_time varchar(255) null,
	plaque_part_2 varchar(255) null,
	plaque_part_1 varchar(255) null,
	plaque_part_3 varchar(255) null,
	driving_license_number varchar(255) null,
	id bigint auto_increment
		primary key
);

create index waybills_first_driver_national_id_index
	on basic.waybills (first_driver_national_id);

create index waybills_issue_date_index
	on basic.waybills (issue_date);

create index waybills_plaque_number_plaque_serial_index
	on basic.waybills (plaque_number, plaque_serial);

create index waybills_second_driver_national_id_index
	on basic.waybills (second_driver_national_id);

create index waybills_waybill_serial_waybill_number_index
	on basic.waybills (waybill_serial, waybill_number);


```
