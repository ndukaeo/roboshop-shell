source common.sh
component=mysql

PRINT Install mysql server
dnf install mysql-server -y &>>$LOG_FILE
STAT $?

PRINT restart my sql serviue
systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
STAT $?

PRINT set up mysql root password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
STAT $?
