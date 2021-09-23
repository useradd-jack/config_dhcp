#!/bin/bash
# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================
. ./fonctions_dhcp/fonc_reservation.sh

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


read -p "Avez-vous un fichier csv ? (O,N) : " choix1
        case $choix1 in

            o|O)

                ##### Zone du fichier csv
                read -p "Renseigner le chemin du \".csv\" :  " path_fic_csv
                # Vérification si le fichier renseigné de path_csv est valide.
                if [ -a "$path_fic_csv" ] ; then

                    echo "Le répertoire "$path_fic_csv" existe et est valide. Les données du fichier $fic_csv sont récupérées"
                    awk -F ";" '{print "\nhost "$1" {\n   hardware ethernet "$2";\n   fixed-address "$3";\n}"}' $path_fic_csv >> $path_fic_dhcp

                else

                    echo "Le chemin que vous avez renseigné n'est pas valide ou le fichier n'existe pas. Veuillez relancer le script avec un chemin valide."
                    # Quitte le script avec le code erreur 3.
                    exit 3

                fi
                ;;

            n|N)

                echo "C'est mieux d'avoir un fichier csv, vous allez tout faire à la main..."
                echo "Les adresses MAC doit être comme ceci: 20:47:47:53:03:da"
                fonc_reservation
                ;;
        esac