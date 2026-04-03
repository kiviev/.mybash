#!/bin/bash
cd ~

echo "clone repo ...."
git clone https://github.com/kiviev/.mybash.git

# check .bashrc

file=~/.bashrc
commands='CONF_DIR=~/.mybash 
SSH_ENV=$HOME/.ssh/environment

source $CONF_DIR/init' 

echo "Add commands to .bashrc ..."
# print commands
if [ ! -e "$file" ] ; then
    echo -e "$commands" > "$file"
else 
	 echo -e "$commands" >> "$file"
fi
