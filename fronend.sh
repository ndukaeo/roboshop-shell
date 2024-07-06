#dnf module disable nginx -y
#dnf module enable nginx:1.24 -y
#dnf install nginx -y
#cp nginx.conf /etc/nginx/nginx.conf
#rm -rf /usr/share/nginx/html/*
#curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
#cd /usr/share/nginx/html
#unzip /tmp/frontend.zip
#systemctl enable nginx
#systemctl restart nginx


source common.sh
component=frontend
app_path=/usr/share/nginx/html

PRINT Disable nginx default version
dnf module disable nginx -y &>>$LOG_FILE
STAT $?

PRINT enable nginx version 24
dnf module enable nginx:1.24 -y &>>$LOG_FILE
STAT $?

PRINT install nginx
dnf install nginx -y &>>$LOG_FILE
STAT $?

PRINT copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
STAT $?

APP_PREREQ

PRINT restart nginx service
systemctl enable nginx &>>$LOG_FILE
systemctl restart nginx &>>$LOG_FILE
STAT $?
