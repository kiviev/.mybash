
function ssh_blink(){
	if [ "$1" != '' ]; then
		echo "ssh $1"
		ssh "$1"
	else
		echo "ssh root@192.168.56.2"
		ssh root@192.168.56.2
	fi
}

function blgo(){
	bl4 && go $1
	bl && go $1
}

function blgof(){
	bl4 && gof $1 $2
	bl && gof $1 $2
}

function blgogo(){
	bl4 && gogo $1 $2
	bl && gogo $1 $2
}

function blflow_start(){
	bl4 && flow_start $1 $2
	bl && flow_start $1 $2
}

function blgit_pub(){
	bl4 && git_pub 
	bl && git_pub 
}

