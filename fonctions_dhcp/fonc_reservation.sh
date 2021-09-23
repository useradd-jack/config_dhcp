fonc_reservation()
{
    read -p "Voulez-vous configurer des réservations ? (O,N) " choix_reservation
    case $choix_reservation in

        o|O)

            echo -e "\n"
            read -p "Avez-vous un fichier csv ? (O,N) : " choix_reservation2
            case $choix_reservation2 in

                o|O)

                    echo -e "\n"
                    read -p "Renseigner le chemin du \".csv\" :  " path_fic_csv
                    path_csv=$(dirname $path_fic_csv)
                    fic_csv=$(basename $path_fic_csv)
                    # Vérification si le fichier renseigné de path_fic_csv est valide.
                    if [ -a "$path_fic_csv" ] ; then

                        echo "Le répertoire "$path_fic_csv" existe et est valide. Les données du fichier $fic_csv sont récupérées"
                        awk -F "\;" '{print "\nhost "$1" {\n   hardware ethernet "$2";\n   fixed-address "$3";\n}"}' $path_fic_csv >> $path_fic_dhcp

                    else

                        echo "Le chemin que vous avez renseigné n'est pas valide ou le fichier n'existe pas. Veuillez relancer le script avec un chemin valide."
                        # Quitte le script avec le code erreur 3.
                        exit 3

                    fi
                    ;;

                n|N)

                    echo -e "\n"
                    echo "Les adresses MAC doivent être comme ceci: 20:47:47:53:03:da"
                    var_reservation_reservation=0
                    read -p "Combien de réservations à configurer (en chiffre) : " nb_reservation_reservation
                    while [ $var_reservation_reservation -ne $nb_reservation_reservation ]
                    do
                        read -p "Quel est le nom de l'hôte : " name_reservation_reservation
                        read -p "Quelle est l'adrese MAC : " mac_reservation_reservation
                        read -p "Quelle est ladresse IP : " ip_reservation_reservation
                        echo -e "\nhost $name_reservation_reservation {" >> $path_fic_dhcp
                        echo "  hardware ethernet $mac_reservation_reservation;" >> $path_fic_dhcp
                        echo "  fixed-address $ip_reservation_reservation;" >> $path_fic_dhcp
                        echo "}" >> $path_fic_dhcp
                        ((var_reservation_reservation=var_reservation_reservation+1))
                    done
                    ;;

                *)
                    echo "Caractère invalide"
                    exit 3
                    ;;
            esac
            ;;

        n|N)

            ;;

        *)
            echo "Caractère invalide"
            exit 3
            ;;

    esac
}