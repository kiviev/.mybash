// # # Cloning repositories


module.exports = {
	gcl :  function (params){ 
		return 'clone ' + f.joinArr(params); 
	},
	gsu :  function (){ return 'submodule update --init --recursive '},
}