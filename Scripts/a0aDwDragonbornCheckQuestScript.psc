Scriptname a0aDwDragonbornCheckQuestScript extends Quest  

GlobalVariable Property a0aDwHasDragonborn auto

Form Test

Event OnInit()
	Test=Game.GetFormFromFile(0x00039d2f,"Dragonborn.esm")
	if(Test)
		a0aDwHasDragonborn.setValue(0.0)
	endif	
EndEvent