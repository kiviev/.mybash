
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
 
 
