
global.fetch = 'fetch ';

module.exports = {
	gf : function (params){ return  fetch + '--all --prune ' + f.joinArr(params)},
	gft :  function (){ return  fetch + '--all --prune --tags '},
	gfv :  function (){ return  fetch + '--all --prune --verbose '},
	gftv :  function (){ return  fetch + '--all --prune --tags --verbose '},
	gfup :  function (){ return  fetch + '&& ' + g + 'rebase '},
}