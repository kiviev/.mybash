// # ## commits

global.commit = 'commit ';

module.exports = {
	c : function (params){ return  commit + '-v ' + f.joinArr(params)},
	gca :  function (){ return  commit + '-v -a '},
	gcm :  function (){ return  commit + '-v -m '},
	gci :  function (){ return  commit + '--interactive '},
	// Show commits since last pull
	gnew :  function (){ return  'log HEAD@{1}..HEAD@{0} '},
	// Add uncommitted and unstaged changes to the last commit
	gcaa :  function (){ return  commit + '-a --amend -C HEAD '},
}