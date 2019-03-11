#!/bin/bash


# tmpfs logger, 2019-02-09 ------>

# create Log folder in /dev/shm
mkdir -p /dev/shm/ShiVaLog

# symlink check
if [ ! -L ~/.shiva/ShiVa/Editor/Log ]; then

	# log dir check
	if [ -d ~/.shiva/ShiVa/Editor/Log ]; then
		# delete dir
		rm -f ~/.shiva/ShiVa/Editor/Log
	else
		# create folder structure
		mkdir -p ~/.shiva/ShiVa/Editor
	fi

	# make a symlink
	ln -s /dev/shm/ShiVaLog ~/.shiva/ShiVa/Editor/Log

fi


# <------ tmpfs logger end


# change dir
# 
TARGETFILE=`readlink -f "$0"`
ABSPATH=`dirname "$TARGETFILE"`
cd "$ABSPATH"

# Tell the dynamic linker to use bundled libs
#
export QT_PLUGIN_PATH="$ABSPATH/Libs/QtPlugins"
export LD_LIBRARY_PATH="$ABSPATH/Libs":$LD_LIBRARY_PATH

# Launch executable
#
./ShiVaEditor "$@"
