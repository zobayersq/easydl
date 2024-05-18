cat << "EOF"



   ▄████████    ▄████████    ▄████████ ▄██   ▄   ████████▄   ▄█
  ███    ███   ███    ███   ███    ███ ███   ██▄ ███   ▀███ ███
  ███    █▀    ███    ███   ███    █▀  ███▄▄▄███ ███    ███ ███
 ▄███▄▄▄       ███    ███   ███        ▀▀▀▀▀▀███ ███    ███ ███
▀▀███▀▀▀     ▀███████████ ▀███████████ ▄██   ███ ███    ███ ███
  ███    █▄    ███    ███          ███ ███   ███ ███    ███ ███
  ███    ███   ███    ███    ▄█    ███ ███   ███ ███   ▄███ ███▌    ▄
  ██████████   ███    █▀   ▄████████▀   ▀█████▀  ████████▀  █████▄▄██
                                                            ▀
            ***Easy File Downloader V0.01***
                        By: Group-3
EOF


echo "Initiating dependency check..."
echo -n "Found: "
for package in wget zenity yt-dlp ffmpeg
do
    which $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed. Installing package $package ..."
        distro=`cat /etc/os-release | grep "ID_LIKE"`
        case ${distro:8} in
            "debian")
                sudo apt update && sudo apt install $package ;;
            "arch")
                sudo pacman -Syu $package ;;
        esac
    fi

done


echo "Teleporting you to cockpit..."



while true
do



    tool_opt1="Audio Video"
    tool_opt2="Other File Type"
    tool_selection=$(zenity --list --title "EasyDL" --text "File/Resource Category" --radiolist --column "" --column "" TRUE "$tool_opt1" FALSE "$tool_opt2")
    case $tool_selection in
        $tool_opt2 )
            resource_opt1="Single File"
            resource_opt2="Entire Directory"
            resource_opt3="Mirror Entire Website"
            resource_dl_option=$(zenity --list --title "EasyDL" --text "File/Resource Download Options" --radiolist --column "" --column "" TRUE "$resource_opt1" FALSE "$resource_opt2" FALSE "$resource_opt3")
            if [ ${#resource_dl_option} -ne 0 ]
            then
                url=$(zenity --entry --title "EasyDL" --text "Enter Target Link")

                case $resource_dl_option in
                    $resource_opt1 )

                        wget -c $url ;;
                    $resource_opt2 )

                        wget -r $url ;;
                    $resource_opt3 )
                        wget -m $url ;;
                esac

            fi

            ;;

        $tool_opt1 )
            resource_opt1="Single Video/Audio File"
            resource_opt2="One Entire Playlist"
            resource_opt3="Whole Chennel"
            resource_dl_option=$(zenity --list --title "EasyDL" --text "File/Resource Download Options" --radiolist --column "" --column "" TRUE "$resource_opt1" FALSE "$resource_opt2" FALSE "$resource_opt3")
            if [ ${#resource_dl_option} -ne 0 ]
            then
                q_opt1="Best Quality"
                q_opt2="Maximum 1080p"
                q_opt3="Maximum 720p"
                q_opt4="Audio Only"
                quality_option=$(zenity --list --title "EasyDL" --text "Choose  Quality" --radiolist --column "" --column "" TRUE "$q_opt1"  FALSE "$q_opt2" FALSE "$q_opt3" FALSE "$q_opt4")
                if [ ${#quality_option} -ne 0 ]
                then
                    url=$(zenity --entry --title "EasyDL" --text "Enter Target Link")


                    case $resource_dl_option in
                        $resource_opt1 )
                            case $quality_option in
                                q_opt1 )
                                    yt-dlp -f best $url ;;
                                q_opt2 )
                                    yt-dlp -f "best[height<=1080]" $url ;;
                                q_opt3 )
                                    yt-dlp -f "best[height<=720]"  $url ;;
                                q_opt4 )
                                    yt-dlp -f bestaudio  $url ;;

                            esac
                                    ;;
                        $resource_opt2 )
                            case $quality_option in
                                q_opt1 )
                                    yt-dlp -f best  -o '%(playlist)s by %(uploader)s' $url ;;
                                q_opt2 )
                                    yt-dlp -f "best[height<=1080]" -o '%(playlist)s by %(uploader)s' $url ;;
                                q_opt3 )
                                    yt-dlp -f "best[height<=720]" -o '%(playlist)s by %(uploader)s'  $url ;;
                                q_opt4 )
                                    yt-dlp -f bestaudio  -o '%(playlist)s by %(uploader)s' $url ;;

                            esac

                            ;;
                        $resource_opt3 )
                            case $quality_option in
                                q_opt1 )
                                    yt-dlp -f best --embed-thumbnail --embed-metadata --download-archive chennel.txt $url -o '%(channel)s/%(title)s.%(ext)s' ;;
                                q_opt2 )
                                    yt-dlp -f "best[height<=1080]" --embed-thumbnail --embed-metadata --download-archive chennel.txt $url -o '%(channel)s/%(title)s.%(ext)s' ;;
                                q_opt3 )
                                    yt-dlp -f "best[height<=720]" --embed-thumbnail --embed-metadata --download-archive chennel.txt $url -o '%(channel)s/%(title)s.%(ext)s' ;;
                                q_opt4 )
                                    yt-dlp -f bestaudio --embed-thumbnail --embed-metadata --download-archive chennel.txt $url -o '%(channel)s/%(title)s.%(ext)s' ;;

                            esac
                        ;;
                    esac
                fi
            fi
            ;;
    esac

    zenity --question --title "EasyDL" --width 500 --height 100 --text "Wanna open download location?"
    if [ $? -eq 0 ]
    then
        xdg-open .
    fi
    zenity --question --title "EasyDL" --width 500 --height 100 --text "To download anything else click 'Yes', To Exit 'No'"
    if [ $? -ne 0 ]
    then
        echo "Seeya!"
        exit
    fi

done
