#!/bin/bash

## opposed to install.cmd i can install by default instead of disabling background processes B)

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list

add-apt-repository multiverse
add-apt-repository ppa:linrunner/tlp

apt update
apt upgrade
apt install software-properties-common apt-transport-https

apt install git
apt install code
apt install mullvad-vpn
apt install p7zip-full p7zip-rar
apt install unrar
apt install tlp tlp-rdw

apt install imwheel
echo "\".*\"" > ~/.imwheelrc
echo "None, Up, Button4, 2" >> ~/.imwheelrc
echo "None, Down, Button5, 2" >> ~/.imwheelrc
echo "Control_L, Up,   Control_L|Button4" >> ~/.imwheelrc
echo "Control_L, Down, Control_L|Button5" >> ~/.imwheelrc

#remove system packages replaced by flatpacks
apt remove --purge firefox*
apt remove --purge Thunderbird*

flatpak install --system flathub org.mozilla.firefox
flatpak install --system flathub org.mozilla.Thunderbird
flatpak install --system flathub org.filezillaproject.Filezilla
flatpak install --system flathub org.freecad.FreeCAD
flatpak install --system flathub org.gimp.GIMP
flatpak install --system flathub fr.handbrake.ghb
flatpak install --system flathub org.inkscape.Inkscape
flatpak install --system flathub org.kde.kdenlive
flatpak install --system flathub org.libreoffice.LibreOffice
flatpak install --system flathub org.videolan.VLC

apt install python3.12-venv
cd ~
python3 -m venv .venv
source .venv/bin/activate
pip=("cchardet" "colorama" "eel" "kivy" "kivymd" "plyer" "opencv-python" "PILLOW" "psutil" "pyinstaller" "pyzbar" "requests" "xlsxwriter" "fpdf" "qrcode" "wxPython" "paramiko", "qtsass")
for lib in "${pip[@]}"
do
    pip install "$lib"
done

alias py='source ~/.venv/bin/activate'
echo "alias py='source ~/.venv/bin/activate'" >> ~/.bashrc

tlp start

# install localhost webserver dev environment
apt install apache2 php php-intl mariadb-server phpmyadmin
systemctl start mariadb.service
systemctl start apache2

#mysql_secure_installation

# fractional scaling primary screen factor 200
xrandr --output eDP-1 --scale 0.5x0.5

flatpak run org.mozilla.firefox https://linuxvox.com/blog/mounting-nas-on-linux/
flatpak run org.mozilla.firefox https://www.decocode.de/?php-lamp-server
flatpak run org.mozilla.firefox https://stackoverflow.com/questions/4221874/how-do-i-allow-https-for-apache-on-localhost/49465073#49465073
flatpak run org.mozilla.firefox https://github.com/EliverLara/Nordic
flatpak run org.mozilla.firefox https://www.gnome-look.org/p/1209330/

