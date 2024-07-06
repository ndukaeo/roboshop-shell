#cp mongo.repo /etc/yum.repos.d/mongo.repo
#dnf install mongodb-org -y
##Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
#sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
#systemctl enable mongod
#systemctl restart mongod
#

source common.sh
component=mongo

PRINT copy mongodb repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo
STAT $?

PRINT install mongodb
dnf install mongodb-org -y
STAT $?

PRINT Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $?

PRINT restart mongodb service
systemctl enable mongod
systemctl restart mongod
STAT $?