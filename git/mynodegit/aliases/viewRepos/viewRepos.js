// # ## view repos

global.remote = 'remote ';

module.exports = {
	gr : function (params){ return  remote  + f.joinArr(params)},
	grv :  function (){ return  remote + '-v '},
	gra :  function (params){ 
		return  remote + 'add ' + f.joinArr(params);
},
}