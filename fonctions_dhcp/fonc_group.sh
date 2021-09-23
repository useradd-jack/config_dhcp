fonc_group()
{
    read -p "Voulez-vous configurer un groupe ? (O,N) " choix_group
    case $choix_group in

        o|O)
            
            read -p "Saisir le nom du groupe, celle-ci peut être \"Etage Administration\" ou autre : " description_group_group
            var_group_group=0
            read -p "Combien d'hôtes seront créés dans le groupe (en chiffre): " nb_host_group_group
            echo -e "\n# $description_group_group" >> $path_fic_dhcp
            echo "group {" >> $path_fic_dhcp
            while [ $var_group_group -ne $nb_host_group_group ]
            do 
                read -p "Saisir le nom de l'hôte : " name_host_group
                read -p "Saisir l'adresse MAC de cet hôte: " mac_host_group_group
                echo "  host $name_host_group {"  >> $path_fic_dhcp
                echo "      hardware ethernet $mac_host_group_group;" >> $path_fic_dhcp
                echo "  }"  >> $path_fic_dhcp
                ((var_group_group=var_group_group+1))
            done
            echo "}" >> $path_fic_dhcp
            ;;

        n|N)

            ;;

        *)
            echo "Caractère invalide"
            exit 3
            ;;

    esac
}