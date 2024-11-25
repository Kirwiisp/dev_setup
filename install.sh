#!/bin/sh
# Function to check for command presence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update and install function based on package manager
install_packages() {
    case "$1" in
        apt)
            echo "Detected Debian/Ubuntu-based system. Using apt."
            sudo apt update 
            sudo apt install -y tmux
            ;;
        pacman)
            echo "Detected Arch-based system. Using pacman."
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm tmux
            ;;
        apk)
            echo "Detected Alpine-based system. Using apk."
            sudo apk update && sudo apk upgrade
            sudo apk add tmux
            ;;
        dnf)
            echo "Detected Fedora-based system. Using dnf."
            sudo dnf upgrade -y
            sudo dnf install -y tmux
            ;;
        yum)
            echo "Detected RHEL-based system. Using yum."
            sudo yum upgrade -y
            sudo yum install -y tmux
            ;;
        zypper)
            echo "Detected openSUSE-based system. Using zypper."
            sudo zypper refresh
            sudo zypper update -y
            sudo zypper install -y tmux
            ;;
        *)
            echo "Unsupported package manager: $1"
            exit 1
            ;;
    esac
}

# Detect the package manager
if command_exists apt; then
    install_packages apt
elif command_exists pacman; then
    install_packages pacman
elif command_exists apk; then
    install_packages apk
elif command_exists dnf; then
    install_packages dnf
elif command_exists yum; then
    install_packages yum
elif command_exists zypper; then
    install_packages zypper
else
    echo "No compatible package manager found. Exiting."
    exit 1
fi

cd dev_setup

# install nvim 
arch=$(uname -m)
if [ $arch = "aarch64" ] ; then	
	tar -xzvf neovim_aarch64_Linux.tar.gz
	sudo mv neovim/usr/local/bin/nvim /bin
	sudo mv neovim/usr/local/share/nvim /usr/local/share
else 
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	export PATH="$PATH:/opt/nvim-linux64/bin"
fi	

# Confirm installation
echo "Installation complete!"
command_exists nvim && echo "Neovim installed successfully."
command_exists tmux && echo "Tmux installed successfully."

cd ..

# Set defaults config ( number/relnumber/hlsearch)
user_conf=$(whoami)
pathdir="/home/$user_conf/.config/nvim"
mkdir -p $pathdir
cp -r dev_setup/configs/nvim ~/.config/
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
rm -rf dev_setup
