#!/bin/bash

DIR="${HOME}/Images/.wall";
NAME="wall.jpg";
TMP="/tmp";
TMPFILE="${TMP}/.tmpfile";
INTERVAL="1h";

HEIGHT=$(xwininfo -root | grep -w Height | cut -d' ' -f4);
WIDTH=$(xwininfo -root | grep -w Width | cut -d' ' -f4);
PREFIX="https:\/\/wallpapers.wallhaven.cc\/wallpapers\/full\/wallhaven\-";
POSTFIX=".jpg";
PAGE="1";
CATEGORY="7";
PURITY="4";
SORTING="random";
ORDER="desc";
ATLEAST="${WIDTH}x${HEIGHT}";
RESOLUTION="${WIDTH}x${HEIGHT}";
VARIABLE="resolutions"; # ou atleast
REQUEST="";


function usage(){
	echo "Usage: ";
	echo "$0 [-i INTERVAL] [ -c CATEGORY] [ -p PURITY] [ -s SORTING] [ -o ORDER] [ -t TYPE_RESOLUTION] [ -q REQUEST]";
	echo -e "\tINTERVAL    : temps d'attente entre la récuperation des images, chiffre suivi du type : \n\t\t\texemple: 10s pour 10 secondes, 10m pour 10 minutes, 10h pour 10 heures";
	echo -e "\tCATEGORY      : 0 = all, 3 = anime+people, 1 = people, 5 = general+people, 4 = general, 6 = general+anime, 7 = general+anime+people, 2 = anime";
	echo -e "\tPURITY        : 4 = sfw, 0 = nsfw, 2 = nsfw+sketchy, 6 = sfw+sketchy";
	echo -e "\tSORTING       : 0 = random, 1 = ....";
	echo -e "\tORDER         : 0 = asc, 1 = desc";
	echo -e "\tTYPE_RESOLUTION : 0 = resolution exacte, 1 = plus petit, 2 = plus grand";
	echo -e "\tREQUEST         : TERM de rechercher";
	#echo -e "\n\t============Valeurs par défaut========================)";
	#AJOUTER ICI LES VALEURS PAR DEFAUT
}

#AJOUTER FONCTION DE VERIFICATION DES OPTIONS ET PARAMETTRES ICI 


while getopts i:c:p:s:o:t:q:h option
do
	case $option in
		i) INTERVAL=$OPTARG ;;
		
		c) CATEGORY=$OPTARG ;;
		
		p) PURITY=$OPTARG ;;

		s) SORTING=$OPTARG ;;

		o) ORDER=$OPTARG ;;

		t) VARIABLE=$OPTARG ;;

		q) REQUEST=$OPTARG ;;

		h) usage ; exit 0 ;;

	esac
done

shift $(($OPTIND - 1));
PURITY=$(echo "x=${PURITY}; scale=3; obase=2; if(x < 2) print 0,0 else if (x < 4) print 0; x" | bc);
CATEGORY=$(echo "x=${CATEGORY}; scale=3; obase=2; if(x < 2) print 0,0 else if (x < 4) print 0; x" | bc);
REQUEST=$(echo "${REQUEST}" | tr "[:blank:]" "[+]");
LINK="https://alpha.wallhaven.cc/search?q=${REQUEST}&categories=${CATEGORY}&purity=${PURITY}&${VARIABLE}=${RESOLUTION}&sorting=${SORTING}&order=${ORDER}&page=${PAGE}";
REGEX="https.*wallpaper/[0-9]{2,9}";
NBPAGE=$(wget -qO - "${LINK}"  | grep -Eo "<h2>Page <span class=\"thumb-listing-page-num\">[0-9]</span> / [0-9]{1,6}</h2>" | grep -Eo "/\ [0-9]{1,6}" | cut -d' ' -f2);

while [ 1 ]
do 
	echo "${LINK}";
	#echo "==================================";
	PAGE=$(( ( RANDOM % ${NBPAGE} ) + 1 ));
	LINK="https://alpha.wallhaven.cc/search?q=${REQUEST}&categories=${CATEGORY}&purity=${PURITY}&${VARIABLE}=${RESOLUTION}&sorting=${SORTING}&order=${ORDER}&page=${PAGE}";
	echo "${LINK}";
	#echo "==================================";
	wget $(lynx -listonly -nonumbers -dump "${LINK}" | grep -Eio "${REGEX}" | grep -Eio "[0-9]{1,9}" | uniq  >"${TMPFILE}" ; sed -n $(( RANDOM % $( wc -l <"${TMPFILE}" ) + 1 ))p "${TMPFILE}" | sed  's#^#'${PREFIX}'#;s/$/'${POSTFIX}'/') -O "${TMP}/${NAME}" && mv -f "${TMP}/${NAME}" "${DIR}/${NAME}" && rm -f "${TMP}/${NAME}";
	sleep "${INTERVAL}";
done
