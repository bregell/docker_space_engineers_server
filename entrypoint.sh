#!/bin/bash -x

set -e

mkdir -p /mnt/steam/space-engineers-server/config
ln -s /mnt/steam/space-engineers-server/config /home/steam/.wine/drive_c/users/steam/Application\ Data/SpaceEngineersDedicated
mkdir -p /mnt/steam/space-engineers-server/config/Saves
mkdir -p /mnt/steam/space-engineers-server/config/Mods
mkdir -p /mnt/steam/space-engineers-server/config/Updater

/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /mnt/steam/space-engineers-server/ +app_update 298740 +quit
wine64 /mnt/steam/space-engineers-server/DedicatedServer64/SpaceEngineersDedicated.exe -console
