// # ## reverting

global.reset = 'reset ';

module.exports = {
	gus : function (){ return  reset + 'HEAD ' },
	gpristine :  function (){ return  reset + '--hard && ' + g + ' clean -dfx '},
}