Scriptname a0aDwDeathItemCoreScript extends ObjectReference  

Race Property DwarvenSpiderRace Auto
Race Property DwarvenSphereRace Auto
Race BallistaRace
Race Property DwarvenCenturionRace Auto

LeveledItem Property a0aDwDeathDefaultCoreSpiderCh25 Auto
LeveledItem Property a0aDwDeathDefaultCoreSphereCh25 Auto
LeveledItem Property a0aDwDeathDefaultCoreBallistaCh25 Auto

Actor aBot


Event  OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	BallistaRace=(Game.GetFormFromFile(0x0002B014,"Dragonborn.esm") as race)
	aBot=(akNewContainer as Actor)
	if(aBot)
		if(aBot.GetRace()==DwarvenSpiderRace)
			aBot.AddItem(a0aDwDeathDefaultCoreSpiderCh25,1)
		elseif(aBot.GetRace()==DwarvenSphereRace)
			aBot.AddItem(a0aDwDeathDefaultCoreSphereCh25,1)
			
			
		elseif(BallistaRace)
			if(aBot.GetRace()==BallistaRace)
				aBot.AddItem(a0aDwDeathDefaultCoreBallistaCh25,1)
			endif
		endif
	endif
	akNewContainer.RemoveItem(getBaseObject(),1)
EndEvent