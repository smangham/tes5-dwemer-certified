Scriptname a0aDwEffectVoiceMenuScript extends activemagiceffect  
{Command Menu}

Quest Property a0aDwQuest Auto
Message Property a0aDwMessageDialogueMenu auto

Event OnEffectStart(Actor Target, Actor Caster)
	Actor StepItem
	Int LoopStep = 0

	Int MenuOption = a0aDwMessageDialogueMenu.Show()
	
	Actor[] TempArray = (a0aDwQuest as a0aDwQuestScript).BotArray
	
	While(LoopStep < TempArray.length)
		StepItem=TempArray[LoopStep]
		if(StepItem)
			if(MenuOption==0)
				(a0aDwQuest as a0aDwQuestScript).RobotFollow(StepItem,false)
			elseif(MenuOption==1)
				(a0aDwQuest as a0aDwQuestScript).RobotWait(StepItem,false)
			elseif(MenuOption==2)
				(a0aDwQuest as a0aDwQuestScript).RobotStanceAggressive(StepItem,false)
			elseif(MenuOption==3)
				(a0aDwQuest as a0aDwQuestScript).RobotStancePassive(StepItem,false)
			elseif(MenuOption==4)
				(a0aDwQuest as a0aDwQuestScript).RobotDeploy(StepItem,false)
			Endif

		endIf
		LoopStep = LoopStep+1
	EndWhile

EndEvent
