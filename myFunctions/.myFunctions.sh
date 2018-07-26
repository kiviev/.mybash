
source $CONF_DIR/myFunctions/blink.sh
source $CONF_DIR/myFunctions/mydefinitions.sh

# my functions

function mssh(){
	USER=''
	IP=''
	ARGS=''

	if [ $1 = 'pi' ]; then
		USER='pi'
		IP='192.168.1.140'
	elif [ $1 = 'vbox' ]; then
		USER='pack'
		IP='192.168.1.145'
	elif [ $1 = '-b' ]; then
		USER='root'
		IP='192.168.56.2'
	elif [ $1 = 'ofertaka' ]; then
		USER='bitnami'
		IP='34.241.115.147'
		ARGS=' -i ~/.ssh/ofertaka.pem '
	else
		echo 'no has indicado argumento o no es valido'
		return
	fi
	if [ $2 = '-r' ]; then
		USER='root'
	fi
	echo "ssh $ARGS$USER@$IP"
	ssh $ARGS$USER@$IP
}

function sshtunel(){
	USER=''
	IP=''
	ARGS=''
	if [ $1 = '-ofertaka' ]; then
		USER='bitnami'
		IP='34.241.115.147'
		ARGS='-N -L 8888:127.0.0.1:80 -i ~/.ssh/ofertaka.pem '
	else
		echo 'no has indicado argumento'
		return
	fi
	echo "ssh $ARGS$USER@$IP"
	ssh $ARGS$USER@$IP
}


function printText(){
	# $1 color
	# $2 text to color
	TEXT=''
	COLOR=''
	if [ "$2" != '' ]; then
		TEXT=$2
	fi
	if [ "$1" != '' ]; then

		if [ "$1" == 'ERROR' ]; then
			COLOR='LIGHT_RED'
		elif [ "$1" == 'WARN' ]; then
			COLOR='YELLOW'
		elif [ "$1" == 'OK' ]; then
			COLOR='LIGHT_GREEN'
		elif [ "$1" == 'COMMAND' ]; then
			COLOR='ORANGE'
		else
			COLOR=$1
		fi
	else
		echo "no color"
		COLOR=$NC
	fi
	echo -e ${!COLOR}$TEXT${NC}
}

# -e ${YELLOW}$(get_repo)${NC}

# function is_array(){
# 	ISARRAY=0
# 	echo "array: "$1

	# declare -a argAry1=("${!1}")
 #    echo "array 2: ""${argAry1[@]}"


# 	ARR="$1"
# 	# echo "length=""${#argAry1[@]}"
# 	if [ "$1" != '' ]; then
# 		echo "antes"
# 		# declare -p {$ARR} | grep -q '^declare \-a' && ISARRAY=true || $ISARRAY=false
# 		# declare -p ARR 2> /dev/null | grep -q '^declare \-a'
# 		if [[ "$(declare -p ARR)" =~ "declare -a" ]]; then
# 			echo "es un array length"
# 		fi
# 	fi
# 	# if [ "$ISARRAY" = true ]; then 
# 	# 	echo "SI"
# 	# else
# 	# 	echo "NO"
# 	# fi
# 	return $ISARRAY
# }

function is_array()
{   
	declare -a ARRAY=("${!1}")
	# Get number of elements in the array
	ELEMENTS=${#ARRAY[@]}
		echo "elementos: "$ELEMENTS
	# Echo each element in array

	if [ "$ELEMENTS" -gt 0 ]; then
		echo "hau mas de 0 elementos"
		return 1
	else
		return 0
	fi

}
# function is_array() {
#     local variable_name=$1
#     return [[ "$(declare -p $variable_name 2>/dev/null)" =~ "declare -a" ]]
# }

function is_array2(){
	declare -a ARRAY=("${!1}")
	# Get number of elements in the array
	ELEMENTS=${#ARRAY[@]}
		echo "elementos: "$ELEMENTS
	# Echo each element in array
	
	if [ "$ELEMENTS" -gt 0 ]; then
		echo "hau mas de 0 elementos"
		for ((i=0; i<$ELEMENTS; i++)); do
		    echo ${ARRAY[${i}]}
		done
	fi


}


function mkdirin(){
	if [ $1 != '' ]; then
		mkdir $1 && cd $1
	else 
		echo 'ERROR No hay directorio que crear'
	fi
}


function xxx(){
	local variable_name=$1
	if [ is_array $1[@] ]; then
		echo "es array"
	else 
		echo "no es array"
	fi
}
 # echo -e ${YELLOW}$(get_repo)${NC}
 # declare -p v | grep -q '^declare \-a' && return || echo no array
 
 
function myip(){
	curl "https://canihazip.com/s"
}