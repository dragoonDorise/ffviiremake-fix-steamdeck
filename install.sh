#!/usr/bin/bash

rm -rf ~/dragoonDoriseTools/ffviiremake-fix-steamdeck
git clone https://github.com/dragoonDorise/ffviiremake-fix-steamdeck.git ~/dragoonDoriseTools/ffviiremake-fix-steamdeck 

#Check on internal
FOLDER="${HOME}/.steam/steam/steamapps/common/FINAL%20FANTASY%20VII%20REMAKE/End/Content/Paks"
if [ -d "$FOLDER" ]; then
	echo "internal"
	#rsync -r --ignore-existing ~/dragoonDoriseTools/ffviiremake-fix-steamdeck/Paks/ ${FOLDER}
fi

#Check on SDCARD
FOLDER="/run/media/mmcblk0p1/steamapps/common/FINAL%20FANTASY%20VII%20REMAKE/End/Content/Paks"
if [ -d "$FOLDER" ]; then
	echo "SD Card"
	#rsync -r --ignore-existing ~/dragoonDoriseTools/ffviiremake-fix-steamdeck/Paks/ ${FOLDER}
fi

rm -rf ~/dragoonDoriseTools/ffviiremake-fix-steamdeck

zenity --question \
	 --title="EmuDeck" \
	 --width=350 \
	 --text="Done! Do you want to return to Game Mode?" \
	 --ok-label="Yes" \
	 --cancel-label="No" 2>/dev/null
ans2=$?
if [ $ans2 -eq 0 ]; then
	qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout
fi
exit