#source common.sh
#cp shipping.service /etc/systemd/system/shipping.service
#NODEJS
#useradd roboshop
#rm -rf /app
#mkdir /app
#curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
#cd /app
#unzip /tmp/cart.zip
#cd /app
#npm install
#systemctl daemon-reload
#systemctl enable cart
#systemctl restart cart

source common.sh
component=cart
app_path=/app

NODEJS