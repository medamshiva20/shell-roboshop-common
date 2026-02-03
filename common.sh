#!/bin/bash

USERID=$(id -u)
LOGS_DIR="/var/log/shell-roboshop"
LOG_FILE="$LOGS_DIR/$0.log"
START_TIME=$(date +%s)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p $LOGS_DIR

echo  "$(date "%Y-%m-%d %H:%M:%S) | Script started executed at:$(date) | tee -a $LOG_FILE

check_root(){
if [ $USERID -ne 0 ] ;
then 
    echo -e "$R Please run this script with root user $N" | tee -a $LOG_FILE
    exit 1
fi
}


VALIDATE(){
    if [ $1 -ne 0 ] ;
    then 
        echo -e "$2...$R FAILURE $N" | tee -a $LOG_FILE
    else
        echo -e "$2...$G SUCCESS $N" | tee -a $LOG_FILE
    fi

    print_total_time(){
        END_TIME=$(date +%s)
        TOTAL_TIME=$(( $ENDTIME - $START_TIME ))
        echo -e "$(date +%Y-%m-%d %H:%M:%S) | Script executed in : $G $TOTAL_TIME $N | tee -a $LOG_FILE
    }
