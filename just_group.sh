#!/bin/bash
# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================
. ./fonctions_dhcp/fonc_group.sh

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

read -p "Voulez-vous configurer un groupe, celui-ci sert si des postes dans votre réseau ne doivent pas avoir accès aux ressources du réseau ou inversement. (O,N) " choix2
        case $choix2 in

            o|O)
                fonc_group
                ;;

            n|N)
                ;;
        esac