#!/bin/bash
while true
do
mysql -u metamoji -p<パスワード_pの間にスペース無し> -h NLB-c7f279df213468c3.elb.us-east-1.amazonaws.com -P 3306 -e "USE metamoji_db1; SELECT * FROM metamoji_test;"
sleep 1
done