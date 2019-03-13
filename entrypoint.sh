#!/bin/bash -x

if [ ! -d "$CONFIG"]; then
	# Setup folder for application data
	mkdir -p "$CONFIG"
fi

if [ ! -d "$CONFIG"/Saves ]; then
	# Setup folder for saves
	mkdir -p "$CONFIG"/Saves
fi

if [ ! -d "$CONFIG"/Mods ]; then
	# Setup folder for mods
	mkdir -p "$CONFIG"/Mods
fi

if [ ! -d "$CONFIG"/Updater ]; then
	# Setup folder for updater
	mkdir -p "$CONFIG"/Updater
fi

if [ ! -d "$CONFIG"/Saves/"$SERVER_NAME" ]; then
	# Setup folder for default save
	mkdir -p "$CONFIG"/Saves/"$SERVER_NAME"
fi

if [ ! -f "$CONFIG"/SpaceEngineers-Dedicated.cfg ]; then
	# Copy standard config file to correct location
	cp /home/steam/SpaceEngineers-Dedicated.cfg "$CONFIG"
	sed -i 's/DefaultSavePath/'$SERVER_NAME'/g' "$CONFIG"/SpaceEngineers-Dedicated.cfg
fi

if [ ! -d /mnt/steam/space-engineers-server ]; then
	# Setup filesystem for application data
	mkdir -p /mnt/steam/space-engineers-server
fi

/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /mnt/steam/space-engineers-server/ +app_update 298740 +quit
wine64 /mnt/steam/space-engineers-server/DedicatedServer64/SpaceEngineersDedicated.exe -console
