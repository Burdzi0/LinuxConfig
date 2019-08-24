#!/usr/bin/env bash

### FUNCTIONS ###
function test_last() {
	if [ $? -eq 0 ]; then
	    echo -n "successful"
	else
    	echo -n "unsuccessful!"
	fi
}
###	###

# Install curl for nix
echo "Install curl with apt"
sudo apt-get install curl -y

# Nix
echo "Installing nix"
curl https://nixos.org/nix/install | sh

chmod +x ./home/burdzi0/.nix-profile/etc/profile.d/nix.sh
./home/burdzi0/.nix-profile/etc/profile.d/nix.sh

# Packages
echo "Updating nix-channel..."
nix-channel --update

packages=(
	git 
	openjdk-8u212-ga
	openjdk-11.0.3-ga
	gradle
	idea-ultimate
	slack
	sublimetext3
	postman
	gnome-terminal
	fish
	vlc
)

for pack in ${packages[*]}
do
    printf "Installing: %s\n" $pack
    nix-env --quiet --install $pack
    printf "Installing %s was %s \n" $pack `test_last $?`
done

# Regolith linux
echo "Installing Regolith linux"
sudo add-apt-repository -y ppa:kgilmer/regolith-stable -y
sudo apt-get update
sudo apt install regolith-desktop
