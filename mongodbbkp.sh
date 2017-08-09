#script for mongodb backup and upload to aws s3
#!/bin/bash

MONGODUMP_PATH="/usr/bin/mongodump"
MONGO_HOST="127.0.0.1"
MONGO_PORT="27017"
TIMESTAMP=`date +%F-%H%M`
S3_BUCKET_NAME="mybucket"
S3_BUCKET_PATH="mongodb-backups"
BACKUPS_DIR="/home/ubuntu/mongodbbkp"

# Create backup
$MONGODUMP_PATH -h $MONGO_HOST:$MONGO_PORT  $HOST

# Add timestamp to backup
mv dump mongodb-$HOSTNAME-$TIMESTAMP
tar cf mongodb-$HOSTNAME-$TIMESTAMP.tar mongodb-$HOSTNAME-$TIMESTAMP

# Upload to S3
s3cmd put mongodb-$HOSTNAME-$TIMESTAMP.tar s3://$S3_BUCKET_NAME/$S3_BUCKET_PATH/mongodb-$HOSTNAME-$TIMESTAMP.tar

#Move to backup directory
#mv mongodb-$HOSTNAME-$TIMESTAMP.tar $BACKUPS_DIR

#Remove From local

rm -rf mongodb-$HOSTNAME-$TIMESTAMP
rm -rf mongodb-$HOSTNAME-$TIMESTAMP.tar

#Cronjob
# 00 01 * * * /bin/bash /home/ubuntu/mongodbbkp/mongodbbkp.sh
