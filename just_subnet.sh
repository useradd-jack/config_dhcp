#!/bin/bash
# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================
. ./fonctions_dhcp/fonc_subnet.sh

echo -e "\nScript pour créer une configuration DHCP sur une machine CentOS.

# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================

 ██████████   █████   █████   █████████  ███████████ 
░░███░░░░███ ░░███   ░░███   ███░░░░░███░░███░░░░░███
 ░███   ░░███ ░███    ░███  ███     ░░░  ░███    ░███
 ░███    ░███ ░███████████ ░███          ░██████████ 
 ░███    ░███ ░███░░░░░███ ░███          ░███░░░░░░  
 ░███    ███  ░███    ░███ ░░███     ███ ░███        
 ██████████   █████   █████ ░░█████████  █████       
░░░░░░░░░░   ░░░░░   ░░░░░   ░░░░░░░░░  ░░░░░   "


##### Zone des variables
path_fic_dhcp="/etc/dhcp/dhcpd.conf"
path_dhcp=$(dirname $path_fic_dhcp)
fic_dhcp=$(basename $path_fic_dhcp)


fonc_subnet