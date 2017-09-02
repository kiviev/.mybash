// # tagging

global.tag = 'tag ';

module.exports = {
	gt : function (params){ return  tag  + f.joinArr(params)},
	gta : function (params){ return  tag + '-a '},
	gtd :  function (params){ return  tag + '-d ' + f.joinArr(params)},
	gtl :  function (params){ return  tag + '-l ' + f.joinArr(params)},

}