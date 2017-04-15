
source $CONF_DIR/myFunctions/blink.sh

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
