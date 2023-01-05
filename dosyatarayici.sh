#!/bin/bash
#dizin
dir="/home/aleyna/bilisimsist/odev"


db_host="localhost"
db_user="postgres"
db_name="mydb"

snapshot=$(ls $dir)

while :
do
	new_snapshot=$(ls $dir)

	filescan=$(diff <(echo "$snapshot") <(echo "$new_snapshot"))

	if [ "$filescan" != "" ]
	then

		psql -h $db_host -U $db_user -d $db_name <<EOF
		INSERT INTO filescan VALUES ('$filescan');
EOF
	snapshot=$new_snapshot
	fi


	#10 saniyede bir tara.
	sleep 10
done
