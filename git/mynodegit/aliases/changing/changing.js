// #changing


global.checkout = 'checkout ';

module.exports = {
	go : function (params){ return  checkout  + f.joinArr(params)},
	gcom : function (params){ return  checkout  + 'master '},
	gcb :  function (params){ return  checkout + '-b ' + f.joinArr(params)},
	gcob :  function (params){ return  checkout + '-b ' + f.joinArr(params)},
	gct :  function (params){ return  checkout + '--track ' + f.joinArr(params)},

}