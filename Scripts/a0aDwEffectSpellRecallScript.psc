Scriptname a0aDwEffectSpellRecallScript extends activemagiceffect  
{Handles teleportation.}

Quest Property a0aDwQuest Auto
VisualEffect Property MGTeleportInEffect auto
Keyword Property a0aDwKeyword auto

Event OnEffectStart(Actor Target, Actor Caster)
	Actor StepItem
	Int LoopStep = 0
	Float HeadAngle
	Actor[] TempArray = (a0aDwQuest as a0aDwQuestScript).BotArray
	
	While(LoopStep < TempArray.length)
		StepItem=TempArray[LoopStep]
		if((StepItem as Actor))
			if(StepItem.HasKeyword(a0aDwKeyword))
				MGTeleportInEffect.Play(StepItem,2)
				StepItem.MoveTo(Caster,Utility.RandomFloat(64,96),Utility.RandomFloat(64,96))
				HeadAngle = StepItem.GetAngleZ()+StepItem.GetHeadingAngle(caster)
				StepItem.SetAngle(0,0,headangle)
				StepItem.SetAV("WaitingForPlayer",0)
				StepItem.EvaluatePackage()
				StepItem.ResetHealthAndLimbs()
				StepItem.StopCombat()
				StepItem.StopCombatAlarm()
				MGTeleportInEffect.Play(StepItem,2)
			endif
		endIf
		LoopStep = LoopStep+1
	EndWhile

EndEvent
