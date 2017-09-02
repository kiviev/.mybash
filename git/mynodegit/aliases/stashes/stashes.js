// # stash

global.stash = 'stash ';

module.exports = {
	gst : function (params){ return  stash  + f.joinArr(params)},
	gstsv :  function (params){ return  stash + 'save ' + f.joinArr(params)},
	gsta :  function (params){ return  stash + 'apply ' + f.joinArr(params)},
	gstl :  function (){ return  stash + 'list '},
	gstp :  function (){ return  stash + 'pop '},
	gstd :  function (){ return  stash + 'drop '},
	gstclear :  function (){ return  stash + 'clear '},
	gstsh :  function (params){ return  stash + '-show ' + f.joinArr(params)},
}