#NODEJS() {
#  dnf module disable nodejs -y
#  dnf module enable nodejs:20 -y
#  dnf install nodejs -y
#  cp ${component}.service /etc/systemd/system/${component}.service
##  cp mongo.repo /etc/yum.repos.d/mongo.repo
#  useradd roboshop
#  rm -rf /app
#  mkdir /app
#  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
#  cd /app
#  unzip /tmp/${component}.zip
#  cd /app
#  npm install
#  systemctl daemon-reload
#  systemctl enable ${component}
#  systemctl restart ${component}
#}


LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
code_dir=$(pwd)

PRINT() {
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo " ######################################## $* ########################################" &>>$LOG_FILE
  echo $*
}

STAT () {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    echo
    echo "Refer to the log file for more information on the error : file path ${LOG_FILE}"
    exit $1
  fi
}

APP_PREREQ () {

  PRINT Adding Application User
  id roboshop &>>$LOG_FILE
  if [ $? -ne 0 ]; then
  useradd roboshop &>>$LOG_FILE
  fi
  STAT $?

  PRINT remove Old Content
  rm -rf ${app_path} &>>$LOG_FILE
  STAT $?

  PRINT Create App directory
  mkdir ${app_path} &>>$LOG_FILE
  STAT $?

  PRINT Download App Content
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  STAT $?

  PRINT Extract App Content
  cd ${app_path}
  unzip /tmp/${component}.zip &>>$LOG_FILE
  STAT $?
}

SYSTEMD_SETUP (){
    PRINT Copy Service file
    cp ${code_dir}/${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
    STAT $?

    PRINT Start Service
    systemctl daemon-reload &>>$LOG_FILE
    systemctl enable ${component} &>>$LOG_FILE
    systemctl restart ${component} &>>$LOG_FILE
    STAT $?
}




NODEJS() {
  PRINT Disable NodeJS Default Version
  dnf module disable nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Enable NodejS 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  STAT $?

  PRINT Install Nodejs
  dnf install nodejs -y &>>$LOG_FILE
  STAT $?

APP_PREREQ

  PRINT Download NodeJS Dependencies
  npm install &>>$LOG_FILE
  STAT $?

SCHEMA_SETUP

SYSTEMD_SETUP


}

JAVA () {
  PRINT install maven and java
  dnf install maven -y &>>$LOG_FILE
  STAT $?

  APP_PREREQ

  PRINT Download java dependencies
  mvn clean package &>>$LOG_FILE
  mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
  STAT $?

SCHEMA_SETUP

SYSTEMD_SETUP

}

SCHEMA_SETUP(){
if  [ "$schema_setup" == "mongo" ]; then
  PRINT Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  STAT $?

  PRINT Install MongoDB Client
  dnf install mongodb-mongosh -y &>>$LOG_FILE
  STAT $?

  PRINT Load Master Data
  mongosh --host localhost </app/db/master-data.js &>>$LOG_FILE
  STAT $?
fi

if  [ "$schema_setup" == "MYSQL" ]; then
  PRINT Install mysql Client
  dnf install mysql -y &>>$LOG_FILE
  STAT $?

  PRINT Load schema
  mysql -h mysql.dev.baneciollc.com -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOG_FILE
  STAT $?

  PRINT Load master data
  mysql -h mysql.dev.baneciollc.com -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOG_FILE
  STAT $?

  PRINT Create app users
  mysql -h mysql.dev.baneciollc.com -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOG_FILE
  STAT $?
fi
}

PYTHON () {
  PRINT install python
  dnf install python3 gcc python3-devel -y &>>$LOG_FILE
  STAT $?

  APP_PREREQ

  PRINT Download python dependencies/requirements
  pip3 install -r requirements.txt &>>$LOG_FILE
  STAT $?

 SYSTEMD_SETUP

}

GOLANG () {
  PRINT install golang
  dnf install golang -y &>>$LOG_FILE
  STAT $?

  APP_PREREQ

  PRINT  golang build
  cd ${app_path}
  go mod init dispatch &>>$LOG_FILE
  go get &>>$LOG_FILE
  go build &>>$LOG_FILE
  STAT $?

  SYSTEMD_SETUP

}