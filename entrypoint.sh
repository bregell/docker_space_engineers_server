#!/bin/bash -x

set -e

mkdir -p /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated
mkdir -p /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Saves
mkdir -p /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Mods
mkdir -p /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Updater

if [ ! -f /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/SpaceEngineers-Dedicated.cfg ]; then
	# Copy default settings if SpaceEngineers-Dedicated.cfg doesn't exist
	cp /mnt/steam/space-engineers-server/SpaceEngineers-Dedicated.cfg /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/SpaceEngineers-Dedicated.cfg
	ls -l /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/
fi

if [ ! -d /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Saves/Nerdz/ ]; then
	# Copy default save if Nerdz doesn't exist
	cp -r /mnt/steam/space-engineers-server/Nerdz /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Saves/Nerdz
	ls -l /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated/Saves/
fi

/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /mnt/steam/space-engineers-server/ +app_update 298740 +quit
wine64 /mnt/steam/space-engineers-server/DedicatedServer64/SpaceEngineersDedicated.exe -console
