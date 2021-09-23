#!/bin/bash
# ==================================================
# Création d'une configuration DHPC
# Auteur: useradd_jack
# Créé le: 21/12/2020
# ==================================================
. ./fonctions_dhcp/fonc_group.sh
. ./fonctions_dhcp/fonc_reservation.sh
. ./fonctions_dhcp/fonc_subnet.sh
. ./fonctions_dhcp/fonc_whitelist.sh

echo -e "\nScript pour créer une configuration DHCP sur une machine Debian.

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
read -p "Renseigner le chemin du fichier de configuration DHCP: " path_fic_dhcp
path_dhcp=$(dirname $path_fic_dhcp)
fic_dhcp=$(basename $path_fic_dhcp)

# Vérification si le chemin $path_dhcp existe
if [ -d "$path_dhcp" ] ; then

    # Vérification si le fichier existe
    if [ -f "$path_fic_dhcp" ] ; then
    
        # Renome le fichier de configuration
        mv $path_fic_dhcp "$path_fic_dhcp.original"

        # Création du nouveau fichier de configuration
        touch $path_fic_dhcp

        # Demande et ajout des informations pour les options générales
        echo -e "\nVous allez configurer les options gérérales du service DHCP ici."
        read -p "Combien de temps dure le bail DHCP (en secondes, par exemple 604800 pour une semaine) : " lease_time
        read -p "Quel est l'adresse IP du serveur DNS principal ? " dns_server1
        read -p "Quel est l'adresse IP du serveur DNS secondaire ? " dns_server2
        read -p "Quel est l'adresse IP du serveur NTP ? " ip_ntp
        read -p "Quel est le nom de domaine ? " name_domain
        echo "max-lease-time $lease_time;" > $path_fic_dhcp
        echo "default-lease-time $lease_time;" >> $path_fic_dhcp
        echo "option ntp-servers $ip_ntp;" >> $path_fic_dhcp
        echo "option time-servers $ip_ntp;" >> $path_fic_dhcp
        echo "option domain-search $name_domain;" >> $path_fic_dhcp
        echo "option domain-name-servers $dns_server1, $dns_server2;" >> $path_fic_dhcp
        echo "option domain-name $name_domain;" >> $path_fic_dhcp

        # Déclaration des whitelist
        echo -e "\n"
        echo "Vous allez configurez ici le ou les whitelist(s), c'est à dire les hôtes qui vont pouvoir accéder au réseau"
        echo -e "\n"
        fonc_whitelist

        # Déclaration des subnets
        echo -e "\n"
        echo "Vous allez configurez ici le(s) subnet(s), c'est à dire le(s) range(s) d'adresses IP disponibles pour les postes utilisateurs"
        echo -e "\n"
        fonc_subnet

        # Déclaration des groupes
        echo -e "\n\nLes groupes servent si des postes dans votre réseau ne doivent pas avoir accès aux ressources du réseau ou inversement."
        echo "Cela peut aussi être un groupe pour organiser les équipements."
        fonc_group
        
        # Déclaration des réservations
        echo -e "\n"
        echo "Vous allez configurez ici le ou les réservation(s), c'est à dire les IP qui seront fixes sur vos équipements informatiques"
        echo -e "\n"
        fonc_reservation


    else

        # Si le fichier n'existe pas
        echo "Le fichier "\"$fic_dhcp\"" n'existe pas et sera créé."
        # Création du nouveau fichier de configuration
        touch $path_fic_dhcp
        echo -e "\nVous allez configurer les options gérérales du service DHCP ici."
        read -p "Combien de temps dure le bail DHCP (en secondes, par exemple 604800 pour une semaine) : " lease_time
        read -p "Quel est l'adresse IP du serveur DNS principal ? " dns_server1
        read -p "Quel est l'adresse IP du serveur DNS secondaire ? " dns_server2
        read -p "Quel est l'adresse IP du serveur NTP ? " ip_ntp
        read -p "Quel est le nom de domaine ? " name_domain
        echo "max-lease-time $lease_time;" > $path_fic_dhcp
        echo "default-lease-time $lease_time;" >> $path_fic_dhcp
        echo "option ntp-servers $ip_ntp;" >> $path_fic_dhcp
        echo "option time-servers $ip_ntp;" >> $path_fic_dhcp
        echo "option domain-search $name_domain;" >> $path_fic_dhcp
        echo "option domain-name-servers $dns_server1, $dns_server2;" >> $path_fic_dhcp
        echo "option domain-name $name_domain;" >> $path_fic_dhcp
        echo "option ConfigServers code 156 = text;" >> $path_fic_dhcp
        
        # Déclaration des whitelist
        echo -e "\n"
        echo "Vous allez configurez ici le ou les whitelist(s), c'est à dire les hôtes qui vont pouvoir accéder au réseau"
        echo -e "\n"
        fonc_whitelist

        # Déclaration des subnets
        echo -e "\n"
        echo "Vous allez configurez ici le(s) subnet(s), c'est à dire le(s) range(s) d'adresses IP disponibles pour les postes utilisateurs"
        echo -e "\n"
        fonc_subnet

        # Déclaration des groupes
        echo -e "\n\nLes groupes servent si des postes dans votre réseau ne doivent pas avoir accès aux ressources du réseau ou inversement."
        echo "Cela peut aussi être un groupe pour organiser les équipements."
        fonc_group
        
        # Déclaration des réservations
        echo -e "\n"
        echo "Vous allez configurez ici le ou les réservation(s), c'est à dire les IP qui seront fixes sur vos équipements informatiques"
        echo -e "\n"
        fonc_reservation

    fi

else

    # Si le répertoire n'existe pas
    echo "Le répertoire que vous avez renseigné "\"$path_dhcp\"" n'existe pas."
    echo -e "Est-ce que le service dhcpd est installé sur le serveur ?"
    read -p "Si ce n'est pas le cas, voulez-vous l'installer ? (O,N) " choix7
    case $choix7 in

        o|O)

            echo "En cours d'installation..."
            apt install isc-dhcp-server -y
            echo "Le service dhcp est installé sur le serveur."
            ;;

        n|N)

            ;;

        *)
            echo "Caractère invalide"
            exit 3
            ;;
    esac

fi

# Fin de la configuration
echo -e "\n\n\n\nLa configuration est faite !\n\n\n"
cat $path_fic_dhcp
echo -e "\n"
echo -e "\n"
echo -e "\n"
read -p "Si cette configuation vous semble correcte, voulez-vous prendre en compte cette configuration pour le serveur DHCP ? (O,N) " choix8
case $choix8 in

    o|O)

        systemctl restart dhcpd
        ;;
    n|N)
        ;;
    *)
        echo "Caractère invalide"
        exit 3
        ;;
esac