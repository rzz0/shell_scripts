#!/bin/bash

#auth:rzz0
# The script uses the find command with the -print0 option and xargs -0 to install the fonts, avoiding issues
# with spaces or #special characters in filenames. 
# Execute with root privileges and adapt the path and the extensions of the fonts to match your specific case.
# ubuntu 22.04


# Set the path to the folder containing the fonts
font_folder="/path/"

find "$font_folder" -type f -name "*.ttf" -or -name "*.otf" -print0 | xargs -0 -I{}  sudo cp "{}" $HOME/.local/share/fonts/

sudo chmod 644 $HOME/.local/share/fonts/*

sudo fc-cache -f -v -s $HOME/.local/share/fonts/

echo "All fonts in $font_folder have been installed and font cache is updated"

