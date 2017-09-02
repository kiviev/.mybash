// # mergings

global.merge = 'merge ';

module.exports = {
	gm : function (params){ return  merge + f.joinArr(params)},
	gclean : function (){ return  'clean -fd '},
	gcp :  function (params){ return  merge + 'cherry-pick ' + f.joinArr(params)},
	gmu :  function (params){ return  fetch + 'origin -v; ' + g + fetch + 'upstream -v; ' + g  + merge + 'upstream/master ' + f.joinArr(params)},
	gmom :  function (params){ return  merge + '-l ' + f.joinArr(params)},

}