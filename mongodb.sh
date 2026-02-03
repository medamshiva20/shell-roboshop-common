#!/bin/bash 

source ./common.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo 
VALIDATE $? "Copying mongo repo"

dnf install mongodb-org -y &>>$LOGS_FILE
VALIDATE $? "Installing MongoDB Server"

systemctl enable mongod
VALIDATE $? "Enable MongoDB"

systemctl start mongod
VALIDATE $? "Start MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections"

systemctl restart mongod
VALIDATE "Restarted MongoDB"


print_total_time