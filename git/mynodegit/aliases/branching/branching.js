// # branches

global.branch = 'branch ';

module.exports = {
	gb : function (params){ return  branch  + f.joinArr(params)},
	gba :  function (params){ return  branch + '-a ' + f.joinArr(params)},
	gbt :  function (params){ return  branch + '--track ' + f.joinArr(params)},
	gdel :  function (params){ return  branch + '-D ' + f.joinArr(params)},

}