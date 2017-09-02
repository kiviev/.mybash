
function joinArr(arr,separator){
		separator = typeof separator == 'undefined' ? ' ' :separator;
		return arr.join(separator)
	}




function ejecutar(func , val , ret = true){
	if(typeof func == 'function'){
		if(ret)	return g + func(val);
		else func(val)	
	}else console.error('No es una funcion válida'.red);
}

exports.joinArr = joinArr;

exports.ejecutar = ejecutar;
