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


sudo mysql -u root <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';


CREATE DATABASE `praksa`;

USE `praksa`;

CREATE TABLE `uservisits` (
  `idUserVisits` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `domain` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUserVisits`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

FLUSH PRIVILEGES;
EOF

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




