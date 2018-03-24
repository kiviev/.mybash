
# funciones que hay que hacer por duplicado en blink

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

function blgoe(){
	bl4 && goe $1 $2
	bl && goe $1 $2
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

function blgit_del_origin(){
	bl4 && git_del_origin $1 $2
	bl && git_del_origin $1 $2
}

function blgit_del_all(){
	bl4 && git_del_all $1 $2
	bl && git_del_all $1 $2
}

function blgit_merge(){
	bl4 && git_merge $1 $2 $3 $4
	bl && git_merge $1 $2 $3 $4
}


function blgit_del_local_lotes(){
	bl4 && git_del_local_lotes $1 $2
	bl && git_del_local_lotes $1 $2
}



function blgdall(){
	bl4 && gdall
	bl && gdall 
}

function blclean_wc(){
	gdall &&  g clean -dfx -e blink/conf/ -e blink/www/wrk/ -e blink/www/node_modules/
	# gpristine -e blink/conf/ -e blink/www/wrk/ -e blink/www/node_modules/

}
