#!/bin/sh
sudo apt-get update
sudp apt-get upgrade

wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
sudo chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest
./dotnet-install.sh --version latest --runtime aspnetcore
./dotnet-install.sh --channel 7.0

sudo cp PraksaStreznik.service /etc/systemd/system/PraksaStreznik.service
sudo systemctl daemon-reload

echo "Čisto zgulfano"
echo ""
echo "Zazeni: systemctl start PraksaStreznik.service"
echo "Oglej: systemctl status PraksaStreznik.service"
echo "Ugasni: systemctl stop PraksaStreznik.service"
echo "Boot: systemctl enable/disable PraksaStreznik.service"
