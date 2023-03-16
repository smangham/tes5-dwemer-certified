Scriptname a0aDwAddonIntSpiderScript extends ObjectReference  
{Upgrades shock damage.}

Spell Property crDwarvenSpiderShock01 auto
Spell Property a0aDwSpellBot1SpiderShockStrong auto
Keyword Property a0aDwKeywordParts1Spider auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	actor ContNew = akNewContainer as actor
	actor ContOld = akOldContainer as actor

	if(ContOld)
		if(ContOld.HasKeyword(a0aDwKeywordParts1Spider))
			contOld.RemoveSpell(a0aDwSpellBot1SpiderShockStrong)
			contOld.AddSpell(crDwarvenSpiderShock01)
		endif
	endif
	
	if(ContNew)
		if(ContNew.HasKeyword(a0aDwKeywordParts1Spider))
			ContNew.RemoveSpell(crDwarvenSpiderShock01)
			ContNew.AddSpell(a0aDwSpellBot1SpiderShockStrong)
		endif
	endif
	
endEvent
