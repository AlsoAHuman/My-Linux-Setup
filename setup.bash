# Check if Script is Run as Root
    if [[ $EUID -ne 0 ]]; then
      echo "You must be a root user to run this script, please run sudo ./setup.sh" 2>&1
      exit 1
    fi

# Adding Nala and Items Needed For Adding Repositories
    sudo apt update
    sudo apt install nala -y
    sudo nala upgrade -y
    sudo nala install -y wget gnupg lsb-release apt-transport-https ca-certificates

# Additional Repositories Added

    #librewolf repo
        distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi) && wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg && sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
        Types: deb
        URIs: https://deb.librewolf.net
        Suites: $distro
        Components: main
        Architectures: amd64
        Signed-By: /usr/share/keyrings/librewolf.gpg
        EOF
    
    #keepassxc repo
        sudo add-apt-repository ppa:phoerious/keepassxc
    
    #flatpak repo
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    
    #protonvpn repo
        wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
        sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb
    
# Installing Apps 
    sudo nala upgrade -y
    
    # Via Nala - (Blender, VLC, Htop, Flatpak, Plasma Discover Flatpak, Neovim, Librewolf, Keepassxc, Proton VPN, KVM/QEMU, Ranger, ADB, Curl) 
        sudo nala install -y blender vlc htop flatpak plasma-discover-backend-flatpak neovim librewolf keepassxc proton-vpn-gnome-desktop qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager ranger adb curl
   
    # Via Flatpak - (Freetube, Bottles, GIMP, Podman GUI) 
        flatpak install flathub io.freetubeapp.FreeTube -y
        flatpak install flathub com.usebottles.bottles -y
        flatpak install flathub org.gimp.GIMP -y
        flatpak install flathub io.podman_desktop.PodmanDesktop -y
    
    # Removes - (Firefox) 
        sudo nala purge firefox -y

# Scripts Setup
    # Replaces Apt With Nala When Applicable
        bash usenala

    # Start & Enable KVM service
        sudo systemctl enable --now libvirtd
        
