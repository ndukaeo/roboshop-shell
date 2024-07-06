source common.sh
component=catalogue
app_path=/app
NODEJS

#cp mongo.repo /etc/yum.repos.d/mongo.repo

echo Install MongoDB Client
dnf install mongodb-mongosh -y &>>$LOG_FILE
STAT $?

echo Load Master Data
mongosh --host localhost </app/db/master-data.js &>>$LOG_FILE
STAT $?

#cp catalogue.service /etc/systemd/system/catalogue.service

#useradd roboshop
#rm -rf /app
#mkdir /app
#curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
#cd /app
#unzip /tmp/catalogue.zip
#cd /app
#npm install
#systemctl daemon-reload
#systemctl enable catalogue
#systemctl restart catalogue