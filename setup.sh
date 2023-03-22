#!/bin/sh
sudo apt-get update
sudp apt-get upgrade

sudo apt-get install wget apt-transport-https -y
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install dotnet-runtime-5.0 -y


wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb
sudo apt install ./mysql-apt-config_0.8.24-1_all.deb -y
sudo apt update
sudo apt update
sudo apt install mysql-server -y



mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

mysql -u root -proot -e "source PraksaSQL.sql"


cat >> /etc/systemd/system/PraksaStreznik.service << EOF
[Unit]

Description=Praksa Streznik



[Service]

Type=simple

WorkingDirectory=$PWD/linux-x64/

ExecStart=/usr/bin/dotnet $PWD/linux-x64/PraksaStreznik.dll

Restart=always

RestartSec=10

SyslogIdentifier=PraStr



[Install]

WantedBy=multi-user.target

EOF

#sudo cp PraksaStreznik.service /etc/systemd/system/PraksaStreznik.service
sudo systemctl daemon-reload

echo "Čisto zgulfano"
echo ""
echo "Zazeni: systemctl start PraksaStreznik.service"
echo "Oglej: systemctl status PraksaStreznik.service"
echo "Ugasni: systemctl stop PraksaStreznik.service"
echo "Boot: systemctl enable/disable PraksaStreznik.service"




