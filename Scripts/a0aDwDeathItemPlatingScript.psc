Scriptname a0aDwDeathItemPlatingScript extends ObjectReference  

Race Property DwarvenSpiderRace Auto
Race Property DwarvenSphereRace Auto
Race BallistaRace
Race Property DwarvenCenturionRace Auto

LeveledItem Property a0aDwDeathDefaultPartsSpiderCh25 Auto
LeveledItem Property a0aDwDeathDefaultPartsSphereCh25 Auto
LeveledItem Property a0aDwDeathDefaultPartsBallistaCh25 Auto
LeveledItem Property a0aDwDeathDefaultPartsCenturionCh25 Auto
Actor aBot


Event  OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	BallistaRace=(Game.GetFormFromFile(0x0002B014,"Dragonborn.esm") as race)
	aBot=(akNewContainer as Actor)
	if(aBot)
		if(aBot.GetRace()==DwarvenSpiderRace)
			aBot.AddItem(a0aDwDeathDefaultPartsSpiderCh25,1)
		elseif(aBot.GetRace()==DwarvenSphereRace)
			aBot.AddItem(a0aDwDeathDefaultPartsSphereCh25,1)
		elseif(aBot.GetRace()==DwarvenCenturionRace)
			aBot.AddItem(a0aDwDeathDefaultPartsCenturionCh25,1)
		elseif(BallistaRace)
			if(aBot.GetRace()==BallistaRace)
				aBot.AddItem(a0aDwDeathDefaultPartsBallistaCh25,1)
			endif
		endif
	endif
	akNewContainer.RemoveItem(getBaseObject(),1)
EndEvent