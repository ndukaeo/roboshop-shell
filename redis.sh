#dnf module disable redis -y
#dnf module enable redis:7 -y
#dnf install redis -y
## Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf
## Update protected-mode from yes to no in /etc/redis/redis.conf
#sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
#sed -i '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
#systemctl enable redis
#systemctl restart redis
source common.sh
component=redis

PRINT disable default redis
dnf module disable redis -y &>>$LOG_FILE
STAT $?

PRINT enable redis 7
dnf module enable redis:7 -y &>>$LOG_FILE
STAT $?

PRINT install redis 7
dnf install redis -y &>>$LOG_FILE
STAT $?

PRINT update redis config
# Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf
# Update protected-mode from yes to no in /etc/redis/redis.conf
sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOG_FILE
STAT $?

PRINT redis service
systemctl enable redis &>>$LOG_FILE
systemctl restart redis &>>$LOG_FILE
STAT $?


