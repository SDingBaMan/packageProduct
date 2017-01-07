#!/bin/bash
cd /home/www/extend_crm
echo 'STEP1: update..................................................'
git pull
echo 'STEP2: compile.................................................'
/usr/share/maven/bin/mvn package -DskipTests -Pdev
echo 'STEP3: stop old................................................'
ps -ef | grep java | grep crm | awk '{print $2}' | xargs kill -9
echo 'STEP4: start new...............................................'
cd /home/www
rm -Rf /home/www/htmob-crm-1.0.0
mv /home/www/extend_crm/crm-web/target/htmob-crm-1.0.0-bin.tar.gz /home/www/
tar -xzvf /home/www/htmob-crm-1.0.0-bin.tar.gz
rm -Rf /home/www/htmob-crm-1.0.0-bin.tar.gz
cd htmob-crm-1.0.0
bin/starter.sh