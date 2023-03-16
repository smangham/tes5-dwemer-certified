Scriptname a0aDwAddonIntSphereScript extends ObjectReference  
{Adds AP ammo}

Ammo Property a0aDwAddonIntSphereArrow auto
Keyword Property a0aDwKeywordParts2Sphere auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	actor ContNew = akNewContainer as actor
	actor ContOld = akOldContainer as actor

	if(ContOld)
		if(ContOld.HasKeyword(a0aDwKeywordParts2Sphere ))
			contOld.RemoveItem(a0aDwAddonIntSphereArrow,999)
		endif
	endif
	
	if(ContNew)
		if(ContNew.HasKeyword(a0aDwKeywordParts2Sphere ))
			ContNew.AddItem(a0aDwAddonIntSphereArrow,100)
			ContNew.EquipItem(a0aDwAddonIntSphereArrow)
		endif
	endif
	
endEvent
