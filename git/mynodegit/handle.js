var f = require('./general.functions'),
	commit = require('./aliases/commit/commit'),
	clone = require('./aliases/cloning/cloning'),
	pull = require('./aliases/pulls/pulls'),
	fetch = require('./aliases/fetches/fetches'),
	status = require('./aliases/status/status'),
	revert = require('./aliases/reverting/reverting'),
	viewRep = require('./aliases/viewRepos/viewRepos'),
	push = require('./aliases/pushes/pushes'),
	staging = require('./aliases/staging/staging'),
	stashing = require('./aliases/stashes/stashes'),
	branching = require('./aliases/branching/branching'),
	changes = require('./aliases/changing/changing'),
	tag = require('./aliases/tagging/tagging'),
	merging = require('./aliases/merging/merging'),
	logs = require('./aliases/logs/logs');




// ley is the alias
module.exports = {
	g 		: function(params){ return f.joinArr(params)},

	/**
	 *********** Aliases ***********
	**/
	// * cloning
	gcl 	: clone.gcl,
	gsu 	: clone.gsu,

	//* getting data from repositories

		// fetches
	gf 		: fetch.gf,
	gft 	: fetch.gft,
	gfv 	: fetch.gfv,
	gftv	: fetch.gftv,
	gfup	: fetch.gfup,
		// pulls
	gl 		: pull.gl,
	glum 	: pull.glum,
	gpr 	: pull.gpr,
	gpp 	: pull.gpp,

	//* repository status
		// status
	gs 		: status.gs,
	gss 	: status.gss,
		// reverting
	gus 	: revert.gus,
	gpristine : revert.gpristine,
		// view repos
	gr 		: viewRep.gr,
	grv 	: viewRep.grv,
	gra 	: viewRep.gra,
		//pushes
	gp 		: push.gp,
	gpo 	: push.gpo,
	gpu 	: push.gpu,
	gpom 	: push.gpom,

	//* commiting
		// commit
	gc 		: commit.c,
	gca 	: commit.gca,
	gcm 	: commit.gcm,
	gci 	: commit.gci,
			// Show commits since last pull
	gnew 	: commit.gnew,
			// Add uncommitted and unstaged changes to the last commit
	gcaa 	: commit.gcaa,
		// staging
	ga 		: staging.ga,
	gap 	: staging.gap,
	gall 	: staging.gall,

	//* logs
	gll 	: logs.gll,
	gg 		: logs.gg,
	ggs 	: logs.ggs,
	gsl 	: logs.gsl,
	gw 		: logs.gw,
	gcount 	: logs.gcount,

	//* stashes

	gst 	: stashing.gst,
	gstsv 	: stashing.gstsv,
	gsta 	: stashing.gsta,
	gstl 	: stashing.gstl,
	gstp 	: stashing.gstp,
	gstd 	: stashing.gstd,
	gstclear: stashing.gstclear,
	gstsh 	: stashing.gstsh,

	//* branching

	gb 		: branching.gb,
	gba 	: branching.gba,
	gbt 	: branching.gbt,
	gdel 	: branching.gdel,

	//* changing

	go 		: changes.go,
	gcom 	: changes.gcom,
	gcb 	: changes.gcb,
	gcob 	: changes.gcob,
	gct 	: changes.gct,

	//* tagging

	gt 		: tag.gt,
	gta 	: tag.gta,
	gtd 	: tag.gtd,
	gtl 	: tag.gtl,

	//* merging

	gm 		: merging.gm,
	gclean 	: merging.gclean,
	gcp 	: merging.gcp,
	gmu 	: merging.gmu,
	gmom 	: merging.gmom,

/**
	 *********** Functions ***********
	**/
	hola: function(){ 
		return pull.gl() + '&& ' + g + status.gs();
	}

	// gxxx : function(){
	// 	return function (){
	// 		return pl.gl ' && ' status.gs
	// 	}
	// }

}