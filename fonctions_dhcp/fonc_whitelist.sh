fonc_whitelist()
{
    read -p "Voulez-vous configurer des whitelists ? (O,N) " choix_whitelist
    case $choix_whitelist in

        O|o)

            # Déclaration du subnet verion whitelist
            echo -e "\n"
            echo "Vous allez configurez ici le ou les subnet(s), c'est à dire les range d'IP disponibles sur vos vlans pour les postes utilisateurs"
            echo -e "\n"
            var_subnet_whitelist=0
            read -p "Combien de subnet à configurer (en chiffre) : " nb_subnet_whitelist
            while [ $var_subnet_whitelist -ne $nb_subnet_whitelist ]
            do
                read -p "Description du subnet : " description_subnet_whitelist
                read -p "Quel est l'adresse de réseau du subnet : " address_network_subnet_whitelist
                read -p "Quel est le masque réseau du subnet : " mask_network_subnet_whitelist
                read -p "Quelle est la première adresse réseau du subnet utilisable : " first_address_subnet_whitelist
                read -p "Quelle est la dernière adresse réseau du subnet utilisable : " last_address_subnet_whitelist
                echo -e "\n# $description_subnet_whitelist" >> $path_fic_dhcp
                echo "subnet $address_network_subnet_whitelist netmask $mask_network_subnet_whitelist {" >> $path_fic_dhcp
                echo "      option routers 10.245.186.199;" >> $path_fic_dhcp
                echo "      option domain-name-servers 7.4.7.9, 2.3.7.9;" >> $path_fic_dhcp
                echo "      option domain-name poo.poo;" >> $path_fic_dhcp
                echo "      option domain-search poo.poo;" >> $path_fic_dhcp
                echo "      range $first_address_subnet_whitelist $last_address_subnet_whitelist;" >> $path_fic_dhcp
                
                # Déclaration du groupe
                read -p "Saisir le nom du groupe, celle-ci peut être \"Whitelist\" ou autre : " description_group_whitelist
                read -p "Quelle est l'IP du serveur DNS principal : " ip_server_dns_whitelist
                read -p "Quelle est l'IP du serveur DNS secondaire : " ip_server_dns2_whitelist
                read -p "Quel est le nom de domaine de recherche : " name_server_dns_whitelist
                read -p "Quelle est l'IP de l passerelle : " ip_gateway_whitelist
                echo -e "  # $description_group_whitelist" >> $path_fic_dhcp
                echo "  group {" >> $path_fic_dhcp
                echo "      option domain-name-servers $ip_server_dns_whitelist, $ip_server_dns2_whitelist;" >> $path_fic_dhcp
                echo "      option domain-search $name_server_dns_whitelist;" >> $path_fic_dhcp
                echo "      option domain-name $name_server_dns_whitelist;" >> $path_fic_dhcp
                echo "      option routers $ip_gateway_whitelist;" >> $path_fic_dhcp
                echo -e "\n"
                
                # Déclaration des hosts
                read -p "Pour l'ajout des host, avez-vous un fichier csv ? (O,N) " choix_whitelist
                case $choix_whitelist in

                    O|o)
                        echo -e "\n"
                        read -p "Renseigner le chemin du \".csv\" :  " path_fic_csv
                        path_csv=$(dirname $path_fic_csv)
                        fic_csv=$(basename $path_fic_csv)
                        # Vérification si le fichier renseigné de path_fic_csv est valide.
                        if [ -a "$path_fic_csv" ] ; then

                            echo -e "Le répertoire "$path_fic_csv" existe et est valide. Les données du fichier $fic_csv sont récupérées\n"
                            awk -F ";" '{print "\n      host "$1" {\n         hardware ethernet "$2";\n      }"}' $path_fic_csv >> $path_fic_dhcp

                        else

                            echo "Le chemin que vous avez renseigné n'est pas valide ou le fichier n'existe pas. Veuillez relancer le script avec un chemin valide."
                            # Quitte le script avec le code erreur 3.
                            exit 3

                        fi
                        ;;

                    N|n)
                        read -p "Combien d'hôtes seront créés dans le groupe (en chiffre): " nb_host_group_whitelist
                        var_group_whitelist=0
                        while [ $var_group_whitelist -ne $nb_host_group_whitelist ]
                        do 
                            read -p "Quel est le nom de l'hôte : " name_reservation_whitelist
                            read -p "Quelle est l'adrese MAC : " mac_reservation_whitelist
                            echo -e "      host $name_reservation_whitelist {" >> $path_fic_dhcp
                            echo "          hardware ethernet $mac_reservation_whitelist;" >> $path_fic_dhcp
                            echo "      }" >> $path_fic_dhcp
                            ((var_group_whitelist=var_group_whitelist+1))
                        done
                        ;;
                esac
                echo "  }" >> $path_fic_dhcp
                echo "}" >> $path_fic_dhcp
                ((var_subnet_whitelist=var_subnet_whitelist+1))
            done
            ;;

        N|n)

            ;;

        *)
            echo "Caractère invalide"
            exit 3
            ;;

    esac
}