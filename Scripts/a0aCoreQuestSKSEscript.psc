Scriptname a0aCoreQuestSKSEscript extends Quest  

bool property bSKSE Auto

Event OnInit()
;	debug.messagebox("SKSE 1: "+bSKSE)
	bSKSE=FALSE
	if(skse.getVersionRelease() > 1)
;		debug.messagebox("SKSE: "+skse.GetVersionRelease())
		bSKSE=TRUE
	endif
;	debug.messagebox("SKSE 2: "+bSKSE)
EndEvent
