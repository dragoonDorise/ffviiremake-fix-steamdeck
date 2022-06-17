#!/usr/bin/bash


zenity --info \
 --title="EmuDeck FFVII Remake Fix" \
 --width=450 \
 --text="Hi! this script will fix FFVII Remake stuttering and low resolution issues." &>> /dev/null	

rm -rf ~/dragoonDoriseTools/ffviiremake-fix-steamdeck
git clone https://github.com/dragoonDorise/ffviiremake-fix-steamdeck.git ~/dragoonDoriseTools/ffviiremake-fix-steamdeck 

#Check on internal
FOLDER="${HOME}/.steam/steam/steamapps/common/FINAL FANTASY VII REMAKE/End/Content/Paks"
if [ -d "$FOLDER" ]; then
	echo "Internal Storage detected"
	rsync -r --ignore-existing ~/dragoonDoriseTools/ffviiremake-fix-steamdeck/Paks/ "$FOLDER"
fi

#Check on SDCARD
FOLDER="/run/media/mmcblk0p1/steamapps/common/FINAL FANTASY VII REMAKE/End/Content/Paks"
if [ -d "$FOLDER" ]; then
	echo "SD Card detected"
	rsync -r --ignore-existing ~/dragoonDoriseTools/ffviiremake-fix-steamdeck/Paks/ "$FOLDER"
fi

echo "Patch applied"

rm -rf ~/dragoonDoriseTools/ffviiremake-fix-steamdeck

zenity --question \
	 --title="EmuDeck" \
	 --width=350 \
	 --text="Done! Do you want to return to Game Mode?" \
	 --ok-label="Yes" \
	 --cancel-label="No" 2>/dev/null
ans2=$?
if [ $ans2 -eq 0 ]; then
	rm -rf ~/FFVIIFIX.desktop
	qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout
fi
rm -rf ~/FFVIIFIX.desktop
exit