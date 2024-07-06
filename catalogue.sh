#source the function
source common.sh
#assign the variable
component=catalogue
#call the function
NODEJS

#cp mongo.repo /etc/yum.repos.d/mongo.repo

echo Install MongoDB Client
dnf install mongodb-mongosh -y &>>$LOG_FILE
if [$? -eq 0]; then
  echo SUCCESS
else
    echo FAILURE
fi

echo Load Master Data
mongosh --host mongo.dev.rdevopsb80.online </app/db/master-data.js &>>$LOG_FILE
if [$? -eq 0]; then
  echo SUCCESS
else
    echo FAILURE
fi

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