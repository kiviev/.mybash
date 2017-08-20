var sh = require('shelljs');
var params=[];
process.argv.forEach(function (val, index, array) {

  // console.log(index + ': ' + val);
if (index >1) params.push(val);
});


	console.log(params);
if(params.length > 0){
	// if (!sh.which('git')) {
	//   sh.echo('Sorry, this script requires git');
	//   sh.exit(1);
	// }
var g = 'git ';
var command = g + params[0];
console.log(command);
sh.exec(command ,{shell: '/bin/bash'})

	
}