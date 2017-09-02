global.pl = 'pull ';

module.exports = {
	gl : function (params){ return  pl + f.joinArr(params) + ' -v '},
	glum :  function (){ return  pl + 'upstream master '},
	gpr :  function (){ return  pl + '--rebase '},
	gpp :  function (){ return  pl + 'pull && ' + g + 'push '},
}