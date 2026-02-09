#!/bin/bash

## opposed to install.cmd i can install by default instead of disabling background processes B)

apt update
apt upgrade
apt install curl ca-certificates -y

curl -fsSL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/vscodium.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/vscodium.sources
Types: deb
URIs: https://download.vscodium.com/debs
Suites: vscodium
Components: main
Signed-By: /usr/share/keyrings/vscodium.gpg
EOF

apt update

curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list

add-apt-repository multiverse
add-apt-repository ppa:linrunner/tlp

apt update
apt upgrade

apt install software-properties-common apt-transport-https

apt install git
apt install codium
codium --install-extension dbaeumer.vscode-eslint ecmel.vscode-html-css yzane.markdown-pdf bierner.markdown-mermaid arcticicestudio.nord-visual-studio-code bmewburn.vscode-intelephense-client esbenp.prettier-vscode ms-python.pylint natizyskunk.sftp
apt install mullvad-vpn
apt install p7zip-full p7zip-rar
apt install unrar
apt install tlp tlp-rdw
apt install dropbox
apt install filezilla
apt install vlc

apt install imwheel
echo "\".*\"" > ~/.imwheelrc
echo "None, Up, Button4, 2" >> ~/.imwheelrc
echo "None, Down, Button5, 2" >> ~/.imwheelrc
echo "Control_L, Up,   Control_L|Button4" >> ~/.imwheelrc
echo "Control_L, Down, Control_L|Button5" >> ~/.imwheelrc

flatpak install --system flathub org.freecad.FreeCAD
flatpak install --system flathub org.gimp.GIMP
flatpak install --system flathub fr.handbrake.ghb
flatpak install --system flathub org.inkscape.Inkscape
flatpak install --system flathub org.kde.kdenlive

apt install python3.12-venv
cd ~
python3 -m venv .venv
source .venv/bin/activate
pip=("cchardet" "colorama" "eel" "kivy" "kivymd" "plyer" "opencv-python" "PILLOW" "psutil" "pyinstaller" "pyzbar" "requests" "xlsxwriter" "fpdf" "qrcode" "wxPython" "paramiko" "qtsass")
for lib in "${pip[@]}"
do
    pip install "$lib"
done

localectl set-locale LANG=en_GB.UTF-8
localectl set-locale LANGUAGE=en_GB
localectl set-locale LC_CTYPE="en_GB.UTF-8"
localectl set-locale LC_NUMERIC=de_DE.UTF-8
localectl set-locale LC_TIME=de_DE.UTF-8
localectl set-locale LC_COLLATE="en_GB.UTF-8"
localectl set-locale LC_MONETARY=de_DE.UTF-8
localectl set-locale LC_MESSAGES="en_GB.UTF-8"
localectl set-locale LC_PAPER=de_DE.UTF-8
localectl set-locale LC_NAME=de_DE.UTF-8
localectl set-locale LC_ADDRESS=de_DE.UTF-8
localectl set-locale LC_TELEPHONE=de_DE.UTF-8
localectl set-locale LC_MEASUREMENT=de_DE.UTF-8
localectl set-locale LC_IDENTIFICATION=de_DE.UTF-8

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

firefox https://linuxvox.com/blog/mounting-nas-on-linux/
firefox https://www.decocode.de/?php-lamp-server
firefox https://stackoverflow.com/questions/4221874/how-do-i-allow-https-for-apache-on-localhost/49465073#49465073
firefox https://github.com/EliverLara/Nordic
firefox https://www.gnome-look.org/p/1209330/
