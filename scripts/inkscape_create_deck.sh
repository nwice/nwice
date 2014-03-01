#!/bin/bash

if [ ! -f "SVG_and_EPS_Vector_Playing_Cards_Version_1.3.zip" ]; then
	wget http://vectorized-playing-cards.googlecode.com/files/SVG_and_EPS_Vector_Playing_Cards_Version_1.3.zip
fi

function copyToDeck {
 echo $1 to `basename $1` 
 cp $1 np_deck/svg/`basename $1` 
}

export -f copyToDeck

function cleanWebDeck {
 if [ -d "np_web_deck" ]; then
    rm -rf "np_web_deck"
 fi
 unzip SVG_and_EPS_Vector_Playing_Cards_Version_1.3.zip -d "np_web_deck"
}

function cleanDeck {
 if [ -d "np_deck" ]; then
	rm -rf "np_deck"
 fi
 mkdir np_deck
 mkdir np_deck/svg
 mkdir np_deck/png
 find "np_web_deck/SVG_Vector_Playing_Cards_Version_1.3/52-Individual-Color-Vector-Playing_Cards-1.3_(SVG-Format_No_Crop_Marks)" -name *.svg -exec bash -c 'copyToDeck "{}"' \;
 copyToDeck "np_web_deck/SVG_Vector_Playing_Cards_Version_1.3/Backs_and_pips_1.3_(No_Crop_Marks)/Blue_Back.svg"
 copyToDeck "np_web_deck/SVG_Vector_Playing_Cards_Version_1.3/Backs_and_pips_1.3_(No_Crop_Marks)/Red_Back.svg"
}

function doResize {
 find np_deck/svg/*.svg -exec inkscape -f {} --verb=FitCanvasToDrawing --verb=FileSave --verb=FileClose \;
}

function exportPlain {
 find np_deck/svg/*.svg -exec inkscape --export-plain-svg={} {} \;
}

function exportPng {
 find np_deck/svg/*.svg -exec inkscape --export-background-opacity=0 --export-png={}.png {} \;
 mv np_deck/svg/*.png np_deck/png/
 rename 's/\.svg//' np_deck/png/*.png 
}

#cleanWebDeck
#cleanDeck
#doResize
#exportPlain
#exportPng

cp -R np_deck/svg ~/git/card/assets/gfx/deck
cp -R np_deck/png ~/git/card/res/drawable/deck
