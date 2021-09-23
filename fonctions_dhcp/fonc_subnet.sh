fonc_subnet()
{
    read -p "Voulez-vous configurer des subnets ? (O,N)" choix_subnet_subnet
    case $choix_subnet_subnet in

        O|o)
            var_subnet_subnet=0
            read -p "Combien de subnet à configurer (en chiffre) : " nb_subnet_subnet
            while [ $var_subnet_subnet -ne $nb_subnet_subnet ]
            do
                read -p "Description du subnet : " description_subnet_subnet
                read -p "Quel est l'adresse de réseau du subnet : " address_network_subnet_subnet
                read -p "Quel est le masque réseau du subnet : " mask_network_subnet_subnet
                read -p "Quel est la passerelle du réseau : " gateway_network_subnet_subnet
                read -p "Quelle est la première adresse réseau du subnet utilisable : " first_address_subnet_subnet
                read -p "Quelle est la dernière adresse réseau du subnet utilisable : " last_address_subnet_subnet
                echo -e "\n# $description_subnet_subnet" >> $path_fic_dhcp
                echo "subnet $address_network_subnet_subnet netmask $mask_network_subnet_subnet {" >> $path_fic_dhcp
                echo "      option routers $gateway_network_subnet_subnet;" >> $path_fic_dhcp
                echo "      range $first_address_subnet_subnet $last_address_subnet_subnet;" >> $path_fic_dhcp
                echo "}" >> $path_fic_dhcp
                ((var_subnet_subnet=var_subnet_subnet+1))
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