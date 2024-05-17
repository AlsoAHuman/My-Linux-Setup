# My-Linux-Setup
Setting up Debian Linux desktop with KDE. Not really much, just what I'll usually install. If you have any reccomendations or something feel free to suggest a change. 


sudo apt update

sudo apt install nala -y

sudo nala upgrade -y

sudo nala install vlc -y

sudo nala install blender -y

sudo nala purge firefox -y

sudo nala install -y wget gnupg lsb-release apt-transport-https ca-certificates

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null

Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo nala update

sudo nala install librewolf -y

sudo nala-get install fastfetch -y
