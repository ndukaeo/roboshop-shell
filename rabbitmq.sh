source common.sh
component=rabbitmq


PRINT Copy repo
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
STAT $?

PRINT rabbitmq server
dnf install rabbitmq-server -y &>>$LOG_FILE
STAT $?

PRINT Start rabbitmq server
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $?

#PRINT Adding Application User and password
#rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
#STAT $?

PRINT Adding Application User and password
id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
fi
STAT $?


PRINT Setting user privileges
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
STAT $?





#  id roboshop &>>$LOG_FILE
#  if [ $? -ne 0 ]; then
#  add_user roboshop roboshop123 &>>$LOG_FILE
#  fi
#  STAT $?