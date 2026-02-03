#!/bin/bash 

source ./common.sh
app_name=shipping

check_root
java_setup
app_setup
systemd_setup

dnf install mysql -y  &>>$LOGS_FILE
VALIDATE $? "Installing MySQL"

mysql -h 10.1.1.243 -pRoboShop@1 -e 'use cities'
if [ $? -ne 0 ]; then

mysql -h 10.1.1.243 -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOGS_FILE
mysql -h 10.1.1.243 -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOGS_FILE
mysql -h 10.1.1.243 -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOGS_FILE

    VALIDATE $? "Loaded data into MySQL"
else
    echo -e "data is already loaded ... $Y SKIPPING $N"
fi

app_restart
print_total_time