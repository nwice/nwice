#! /bin/bash

if [ ! -d "np_deck/montage_hands" ]; then
 mkdir np_deck/montage_hands
fi

#montage -geometry +1+1 montage_hands/temp.png montage_hands/temp2.png montage_hands/hand.png 


function card_icon {
	if [ ! -d "np_deck/montage_hands/card" ]; then
	 echo 'create'
	 mkdir np_deck/montage_hands/card
	else
	 echo 'clean'
	 rm -rf np_deck/montage_hands/card/*.png
	fi
	
	convert -background none -rotate -45 np_deck/png/Red_Back.png np_deck/montage_hands/card/red.png
	convert -background none -rotate 45 np_deck/png/Blue_Back.png np_deck/montage_hands/card/blue.png
	convert -background none np_deck/montage_hands/card/red.png np_deck/montage_hands/card/blue.png -composite np_deck/montage_hands/card/bluecross.png
	convert -background none np_deck/montage_hands/card/blue.png np_deck/montage_hands/card/red.png -composite np_deck/montage_hands/card/redcross.png
}

function fav_icon {
	convert -background transparent -resize x16 -gravity center np_deck/montage_hands/card/bluecross.png -flatten -colors 256 ../favicon.ico 
}

function war_icons {
	if [ ! -d "montage_hands/war" ]; then
	 echo 'clean'
	 mkdir montage_hands/war
	else
	 echo 'clean'
	 rm -rf montage_hands/war/*.png
	fi
	
	
	#convert -background none -fill black -pointsize 72 -font URW-Bookman-Demi-Bold-Italic label:'WAR!'  \( -background black -shadow 100x1+2+2 \) montage_hands/war/text.png
}


card_icon
fav_icon
