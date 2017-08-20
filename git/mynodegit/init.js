var sh = require('shelljs');
require('colors');
// var t = require('./test');
var handle = require('./handle');
global.f = require('./general.functions');
var params=[];

process.argv.forEach(function (val, index, array) {
	if (index >1) params.push(val);
});
if(params.length <= 0) return;

// empezamos
global.g = 'git ';
var command;

if(params[0] == '-c'){
	params.splice(0,1);
	command = g + f.joinArr(params);
} 
else{
	var funcion = handle[params[0]];
	params.splice(0,1);
	command = f.ejecutar(funcion, params);
	// com = g + f.joinArr(params);
}

console.log('commando: ' + command);
sh.exec(command ,{shell: '/bin/bash'});