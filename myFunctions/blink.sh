
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


function  blgo_pull(){
	bl4 && go $1 && gl
	bl && go $1 && gl	
}

function blgit_del_local(){
	bl4 && git_del_local $1 $2
	bl && git_del_local $1 $2
}

function blgit_merge(){
	bl4 && git_merge $1 $2 $3 $4
	bl && git_merge $1 $2 $3 $4
}