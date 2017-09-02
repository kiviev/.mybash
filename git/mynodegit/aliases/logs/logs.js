// ## logs

var graph = "--graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative "
global.log = 'log ';

module.exports = {
	gll :  function (){ return  log + "--graph --pretty=oneline --abbrev-commit "},
	gg :  function (){ return  log + graph},
	ggs :  function (){ return  log + graph + " --stat"},
	gsl :  function (params){ return 'shortlog -sn ' + f.joinArr(params)},
	gw :  function (params){ return 'whatchanged ' + f.joinArr(params)},
	gcount :  function (params){ return   'shortlog -sn ' + f.joinArr(params)},
}