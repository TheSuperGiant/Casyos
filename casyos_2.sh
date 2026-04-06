#!/usr/bin/env bash
# Disclaimer:
# This script is provided as-is, without any warranty or guarantee.
# By using this script, you acknowledge that you do so at your own risk.
# I am not responsible for any damage, data loss, or other issues that may result from the use of this script.

AUR_helper="paru"

#pre_2
source <(curl -s -L https://raw.githubusercontent.com/TheSuperGiant/Arch/refs/heads/main/parts/pre_2.sh)

sud

#dns
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/dns.sh)

#special links
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/Special_link.sh)

#functions needs
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/functions_needs__list.sh)

#functions + alias adding
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/functions_alias_adding__Arch.sh)

#add_device_label
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/add_device_label.sh)

#personal folders
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/personal_folders.sh)

box_part "System update"
#box_part "updating"

#sudo paru -Syu --noconfirm
sudo $AUR_helper -Syu --noconfirm

#install needs
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/install_need.sh)

#install needs
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/install_needs.sh)

if [[ "$Firewall__Default" == "1" ]]; then
	ufw=1
	if [[ "$firewall_Recommanded_rules" == "1" ]]; then
		fail2ban=1
	fi
fi

box_part "Installing programs"

if [[ "$App_Install__virt_viewer" == 1 ]] && systemd-detect-virt | grep -q "kvm\|qemu"; then
	sudo pacman -S --noconfirm spice-vdagent
	sudo systemctl enable spice-vdagentd
	sudo systemctl start spice-vdagentd
fi

#app install
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/app_install.sh)

#security
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/security.sh)

#Flatpak app settings
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/flatpak_app_settings.sh)

#settings
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/settings.sh)

#github repos
if [[ "$script_main" == 1 || "$script_startup" == 1 ]]; then
	git_repo__thesupergiant__casyos=1
fi

#github updater
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/github_git_repo.sh)

#suders adding
source <(curl -s -L $TheSuperGiant_Arch_repo_uri__parts/sudoers_adding.sh)
