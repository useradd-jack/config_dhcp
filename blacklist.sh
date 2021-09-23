#!/bin/bash
# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================
. ./fonctions_dhcp/fonc_group.sh
. ./fonctions_dhcp/fonc_reservation.sh
. ./fonctions_dhcp/fonc_subnet.sh

echo -e "\nScript pour créer une configuration DHCP sur une machine CentOS.

# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 23/12/2020
# ==================================================

 ██████████   █████   █████   █████████  ███████████ 
░░███░░░░███ ░░███   ░░███   ███░░░░░███░░███░░░░░███
 ░███   ░░███ ░███    ░███  ███     ░░░  ░███    ░███
 ░███    ░███ ░███████████ ░███          ░██████████ 
 ░███    ░███ ░███░░░░░███ ░███          ░███░░░░░░  
 ░███    ███  ░███    ░███ ░░███     ███ ░███        
 ██████████   █████   █████ ░░█████████  █████       
░░░░░░░░░░   ░░░░░   ░░░░░   ░░░░░░░░░  ░░░░░   


Un fichier \".csv\" peut être mis dans le script pour créer des réservations.
Les réservations peuvent être utilisées pour les imprimantes par exemple.
Le fichier csv doit être configurer sans en-têtes et comme suit:


nom du host;MAC;IP
nom du host;MAC;IP
nom du host;MAC;IP
nom du host;MAC;IP
nom du host;MAC;IP\n\n"


##### Zone des variables
path_fic_dhcp="/mnt/c/Data/mount_kali/exist.conf"
path_dhcp=$(dirname $path_fic_dhcp)
fic_dhcp=$(basename $path_fic_dhcp)


# Renome le fichier de configuration
mv $path_fic_dhcp "$path_fic_dhcp.original"
# Création du nouveau fichier de configuration
touch $path_fic_dhcp
# Insère les options du fichier de configuration
echo "max-lease-time 604800;" > $path_fic_dhcp
echo "default-lease-time 604800;" >> $path_fic_dhcp
echo "option domain-search poo.poo;" >> $path_fic_dhcp
echo "option domain-name-servers 6.2.8.9, 33.88.55.88;" >> $path_fic_dhcp
echo "option domain-name poo.poo;" >> $path_fic_dhcp

# Déclaration des subnets
echo -e "\n"
echo "Vous allez configurez ici le ou les subnet(s), c'est à dire les range d'IP disponibles sur vos vlans pour les postes utilisateurs"
echo -e "\n"
var_subnet=0
read -p "Combien de subnet à configurer (en chiffre) : " nb_subnet
while [ $var_subnet -ne $nb_subnet ]
do
    read -p "Description du subnet : " description_subnet
    read -p "Quel est l'adresse de réseau du subnet : " address_network_subnet
    read -p "Quel est le masque réseau du subnet : " mask_network_subnet
    read -p "Quel est la passerelle du réseau : " gateway_network_subnet
    read -p "Quelle est la première adresse réseau du subnet utilisable : " first_address_subnet
    read -p "Quelle est la dernière adresse réseau du subnet utilisable : " last_address_subnet   
    echo -e "\n# $description_subnet" >> $path_fic_dhcp
    echo "subnet $address_network_subnet netmask $mask_network_subnet {" >> $path_fic_dhcp
    echo "      option routers $gateway_network_subnet;" >> $path_fic_dhcp
    echo "      range $first_address_subnet $last_address_subnet;" >> $path_fic_dhcp
    read -p "Saisir le nom du groupe, celle-ci peut être \"Whitelist\" ou autre : " description_group
    read -p "Quelle est l'IP du serveur DNS principal : " ip_server_dns
    read -p "Quelle est l'IP du serveur DNS secondaire : " ip_server_dns2
    read -p "Quel est le nom de domaine de recherche : " name_server_dns
    echo -e "  # $description_group" >> $path_fic_dhcp
    echo "  group {" >> $path_fic_dhcp
    echo "      option domain-name-servers $ip_server_dns, $ip_server_dns2;" >> $path_fic_dhcp
    echo "      option domain-search $name_server_dns;" >> $path_fic_dhcp
    echo "      option domain-name $name_server_dns;" >> $path_fic_dhcp
    echo -e "\n"
    read -p "Pour l'ajout des host, avez-vous un fichier csv ? (O,N) " choix_blacklist
    case $choix_blacklist in

        O|o)
            echo -e "\n"
            read -p "Renseigner le chemin du \".csv\" :  " path_fic_csv
            path_csv=$(dirname $path_fic_csv)
            fic_csv=$(basename $path_fic_csv)
            # Vérification si le fichier renseigné de path_fic_csv est valide.
            if [ -a "$path_fic_csv" ] ; then

                echo "Le répertoire "$path_fic_csv" existe et est valide. Les données du fichier $fic_csv sont récupérées"
                awk -F ";" '{print "\n      host "$1" {\n         hardware ethernet "$2";\n      }"}' $path_fic_csv >> $path_fic_dhcp

            else

                echo "Le chemin que vous avez renseigné n'est pas valide ou le fichier n'existe pas. Veuillez relancer le script avec un chemin valide."
                # Quitte le script avec le code erreur 3.
                exit 3

            fi
            ;;

        N|n)
            read -p "Combien d'hôtes seront créés dans le groupe (en chiffre): " nb_host_group
            var_group=0
            while [ $var_group -ne $nb_host_group ]
            do 
                read -p "Quel est le nom de l'hôte : " name_reservation
                read -p "Quelle est l'adrese MAC : " mac_reservation    
                echo -e "      host $name_reservation {" >> $path_fic_dhcp
                echo "          hardware ethernet $mac_reservation;" >> $path_fic_dhcp
                echo "      }" >> $path_fic_dhcp
                ((var_group=var_group+1))
            done
            ;;
    esac
    echo "  }" >> $path_fic_dhcp
    echo "}" >> $path_fic_dhcp
    ((var_subnet=var_subnet+1))
done