Scriptname a0aDwAddonIntSteamScript extends ObjectReference  
{Adds/upgrades steam breath.}

Shout  Property crCenturionBreathWeaponMal auto
Shout Property crCenturionBreathWeapon auto
Keyword Property a0aDwKeywordParts3Legionary auto
Keyword Property a0aDwKeywordParts4Simulacra auto
Keyword Property a0aDwKeywordParts5Centurion auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	actor ContNew = akNewContainer as actor
	actor ContOld = akOldContainer as actor

	if(ContOld)
		if(ContOld.HasKeyword(a0aDwKeywordParts3Legionary)||ContOld.HasKeyword(a0aDwKeywordParts4Simulacra))
			;Debug.MessageBox("Removing steam breath")
			contOld.RemoveShout(crCenturionBreathWeaponMal)
		elseif(ContOld.HasKeyword(a0aDwKeywordParts5Centurion))
			;Debug.MessageBox("Weakening steam breath")
			contOld.RemoveShout(crCenturionBreathWeapon )
			contOld.AddShout(crCenturionBreathWeaponMal)
		endif
	endif
	
	if(ContNew)
		if(ContNew.HasKeyword(a0aDwKeywordParts3Legionary)||ContOld.HasKeyword(a0aDwKeywordParts4Simulacra))
			;Debug.MessageBox("Adding steam breath")
			ContNew.AddShout(crCenturionBreathWeaponMal)
		elseif(ContNew.HasKeyword(a0aDwKeywordParts5Centurion))
			;Debug.MessageBox("Improving steam breath")
			ContNew.RemoveShout(crCenturionBreathWeaponMal)
			ContNew.AddShout(crCenturionBreathWeapon )
		endif
	endif
	
endEvent
