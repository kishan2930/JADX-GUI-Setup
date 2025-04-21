#!/bin/bash

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ASCII BANNER
clear
echo -e "${CYAN}"
cat << "EOF"
     _     _     ___   __  __         ___   _   _   ___ 
  _ | |   /_\   |   \  \ \/ /  ___   / __| | | | | |_ _|
 | || |  / _ \  | |) |  >  <  |___| | (_ | | |_| |  | | 
  \__/  /_/ \_\ |___/  /_/\_\        \___|  \___/  |___|
                                                        
EOF
echo -e "${RESET}${YELLOW}        JADX Setup & Management Script for Ubuntu${RESET}"
echo -e "${MAGENTA}               Author: Kishan Ambaliya${RESET}"
echo -e "${BLUE}         GitHub: https://github.com/kishan2930${RESET}\n"

# TOOL PATH
JADX_PATH="/opt/jadx/bin/jadx"
JADX_GUI_PATH="/opt/jadx/bin/jadx-gui"

# MAIN MENU
function show_menu() {
    echo -e "${GREEN}==== Menu ====${RESET}"
    echo -e "1. ${CYAN}Install/Update JADX${RESET}"
    echo -e "2. ${CYAN}Uninstall JADX${RESET}"
    echo -e "3. ${CYAN}Quit${RESET}"
    echo
    read -p "Choose an option (1/2/3): " choice
}

# INSTALL OR UPDATE
function install_or_update_jadx() {
    # Check if jadx is already installed
    if [[ -f "$JADX_PATH" ]]; then
        CURRENT_VERSION=$($JADX_PATH --version | grep -oE '[0-9.]+')
        echo -e "${YELLOW}📦 JADX is already installed. Version: ${CYAN}$CURRENT_VERSION${RESET}"
        echo -e "${MAGENTA}Do you want to update to the latest version?${RESET}"
        echo "1. Yes, update JADX"
        echo "2. No, exit"
        read -p "Enter your choice (1/2): " update_choice
        if [[ "$update_choice" != "1" ]]; then
            echo -e "${RED}❌ Exiting without updating.${RESET}"
            exit 0
        else
            echo -e "${YELLOW}🔄 Removing old version...${RESET}"
            sudo rm -rf /opt/jadx
        fi
    fi

    echo -e "${CYAN}📥 Installing latest JADX version...${RESET}"
    sudo apt update
    sudo apt install -y zip curl unzip

    JADX_VERSION=$(curl -s "https://api.github.com/repos/skylot/jadx/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo jadx.zip "https://github.com/skylot/jadx/releases/latest/download/jadx-${JADX_VERSION}.zip"
    unzip jadx.zip -d jadx-temp

    sudo mkdir -p /opt/jadx/bin
    sudo mv jadx-temp/bin/jadx /opt/jadx/bin
    sudo mv jadx-temp/bin/jadx-gui /opt/jadx/bin
    sudo mv jadx-temp/lib /opt/jadx

    echo 'export PATH=$PATH:/opt/jadx/bin' | sudo tee -a /etc/profile > /dev/null
    source /etc/profile

    rm -rf jadx.zip jadx-temp

    echo -e "${GREEN}✅ JADX v${JADX_VERSION} installed successfully!${RESET}"
    jadx --version
}

# UNINSTALL
function uninstall_jadx() {
    echo -e "${RED}⚠️ Uninstalling JADX...${RESET}"
    sudo rm -rf /opt/jadx
    sudo sed -i '/export PATH=\$PATH:\/opt\/jadx\/bin/d' /etc/profile
    source /etc/profile
    echo -e "${RED}❌ JADX uninstalled.${RESET}"
}

# MAIN
show_menu
case $choice in
    1) install_or_update_jadx ;;
    2) uninstall_jadx ;;
    3) echo -e "${MAGENTA}👋 Exiting. Thanks for using the script.${RESET}"; exit 0 ;;
    *) echo -e "${RED}Invalid option. Exiting.${RESET}"; exit 1 ;;
esac
