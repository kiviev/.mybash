// # # pushses

global.push = 'push ';

module.exports = {
	gp : function (params){ return  push  + f.joinArr(params)},
	gpo :  function (params){ return  push + 'origin ' + f.joinArr(params)},
	gpu :  function (){ return  push + '-v -m '},
	gpom :  function (){ return  push + 'origin master '},
}