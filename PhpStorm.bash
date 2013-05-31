#!/bin/bash
clear
echo "        .  .::  PhpStorm  ::.  .         "
echo ""
echo "========== 1) Telechargement ============="
if ! [ -f ~/net-home/PhpStorm-* ]
then
	echo "tar.gz downloading"
	cd ~/net-home/
	url=http://www.jetbrains.com/phpstorm/download/download_thanks.jsp?os=linux
	search=http://download.jetbrains.com/webide
	lien=$(lynx -dump -listonly $url | grep $search)
	wget ${lien:6}

	if [ $? != 0 ] 
	then
		echo "Download error"
		exit 1
	fi
	echo "tar.gz downloaded"
else
 	echo "tar.gz already download"
fi
NomFic=$(basename $(ls ~/net-home/PhpStorm-*.tar.gz))
NomAbs=${NomFic%%-*}
echo "Nom : $NomAbs"
echo "Archive : $NomFic"
echo ""
echo "========== 2) Extraction ================="

if ! [ -d ~/Bureau/$NomAbs-* ]
then
    echo "/!\\ PhpStorm Extracting /!\\"    
	cd ~/Bureau	
	tar -xzf ~/net-home/$NomFic &
	while ! [ -f ~/Bureau/$NomAbs-*/plugins/sass/lib/stubs/sass_functions.scss ];
	do
		sleep 1
		echo -n "."
	done   
	echo ""
    echo "/!\\ PhpStorm Successfully Extracted /!\\"
else 
    echo "PhpStorm already in \"Bureau\""
fi
echo ""
NomFold=$(basename $(ls -d ~/Bureau/PhpStorm-*))
echo "Dossier : $NomFold"
echo ""
sleep 1 
echo "========== 3) Start ======================"
ps alx | grep Didea.platform.prefix=PhpStorm |grep -v grep > /dev/null
if [ $? == 0 ]
then
	echo "PhpStorm already running"
else
	sleep 1
	cd ~/Bureau/$NomFold/bin
	sleep 1
	sh ./phpstorm.sh &> /dev/null &
	echo "PhpStorm started"
fi
echo ""
echo "========== 4) Details ===================="
~/net-home/.pcdebian/Key-Phpstorm.bash
echo "           .:: Thank you ::."
echo "                By Belias,"
echo "                          LaPorte,"
echo "                                  Tuxayo."
echo ""
echo ""
exit 0
