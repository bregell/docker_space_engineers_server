#!/bin/bash

set -x

if [ ! -d ${WORK} ]; then
	# Setup folder for steamcmd data
	mkdir -p ${WORK}
fi

if [ ! -d ${CONFIG} ]; then
	# Setup folder for space engineers data
	mkdir -p ${CONFIG}
fi

if [ ! -d ${CONFIG}/Saves ]; then
	# Setup folder for saves
	mkdir -p ${CONFIG}/Saves
fi

if [ ! -d ${CONFIG}/Mods ]; then
	# Setup folder for mods
	mkdir -p ${CONFIG}/Mods
fi

if [ ! -d ${CONFIG}/Updater ]; then
	# Setup folder for updater
	mkdir -p ${CONFIG}/Updater
fi

if [ -d ${WORK}/${SERVER_NAME} ]; then
	# Copy save to save location
	cp -r ${WORK}/${SERVER_NAME} ${CONFIG}/Saves/
	chown -R root:root ${CONFIG}/Saves/${SERVER_NAME}
fi

if [ ! -f ${CONFIG}/SpaceEngineers-Dedicated.cfg ]; then
	# Copy standard config file to correct location
	cp /home/root/SpaceEngineers-Dedicated.cfg ${CONFIG}
fi

# Change save path to value from config
sed -i 's/DefaultSavePath/'${SERVER_NAME}'/g' ${CONFIG}/SpaceEngineers-Dedicated.cfg

/home/root/steamcmd/steamcmd.sh +login anonymous +force_install_dir ${WORK} +app_update 298740 +quit
cd ${WORK}/DedicatedServer64
wine SpaceEngineersDedicated.exe -noconsole -ignorelastsession -path Z:\\mnt\\root\\space-engineers-server\\config
