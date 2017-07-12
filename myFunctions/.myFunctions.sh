
source $CONF_DIR/myFunctions/blink.sh
source $CONF_DIR/myFunctions/mydefinitions.sh

# my functions

function mssh()
{
USER=''
IP=''
if [ $1 = '-p' ]; then
	USER='pi'
	IP='192.168.1.120'
elif [ $1 = '-b' ]; then
	USER='root'
	IP='192.168.56.2'
else
	echo 'no has indicado argumento'
	return
fi
echo "ssh $USER@$IP"
	ssh $USER@$IP
}



function printText(){
	TEXT=''
	COLOR=''
	if [ "$1" != '' ]; then
		TEXT=$1
	fi
	if [ "$2" != '' ]; then
		COLOR=$2
		echo "color: "$COLOR
	else
		echo "no color"
		COLOR=$NC
	fi
	echo "color2: "$COLOR
	echo -e ${$COLOR}$TEXT${NC}
}


 # echo -e ${YELLOW}$(get_repo)${NC}