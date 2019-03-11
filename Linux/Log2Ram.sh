#!/usr/bin/env bash
# 2019-02-09 Felix Caffier

# create Log folder in /dev/shm
mkdir -p /dev/shm/ShiVaLog

# symlink check
if [ -L ~/.shiva/ShiVa/Editor/Log ]; then
	echo "~/.shiva/ShiVa/Editor/Log is already a symbolic link."
	echo "You may now launch ShiVa 2.0!"
exit 0
fi

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

echo "Symlink to /dev/shm/ShiVaLog created."
echo "You may now launch ShiVa 2.0!"
exit 0
#EOF
