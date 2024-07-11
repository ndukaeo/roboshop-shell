#source common.sh
#cp shipping.service /etc/systemd/system/shipping.service
#NODEJS
#useradd roboshop
#rm -rf /app
#mkdir /app
#curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
#cd /app
#unzip /tmp/user.zip
#cd /app
#npm install
#systemctl daemon-reload
#systemctl enable user
#systemctl restart user

source common.sh
component=user
app_path=/app

NODEJS