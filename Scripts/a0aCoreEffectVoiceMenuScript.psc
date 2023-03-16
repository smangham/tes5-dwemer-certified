Scriptname a0aCoreEffectVoiceMenuScript extends activemagiceffect  
{Command Menu}

Import Debug

Quest Property a0aCoreQuest Auto
Quest Property a0aCoreQuestSKSE Auto
Message Property a0aCoreMessageDialogueMenu auto
Message Property a0aCoreMessageDialogueMenuSingle auto
Spell Property a0aCoreSpellVoiceMenuActor auto
Spell Property a0aCoreSpellVoiceMenuLocation auto
ObjectReference Property CoreLocationRefDummy auto
ObjectReference Property CoreLocationRef1 auto
ObjectReference Property CoreLocationRef2 auto
GlobalVariable Property a0aCoreGlobalMenuActor auto
GlobalVariable Property a0aCoreGlobalMenuLocation auto
FormList Property a0aCoreFormExplosionLoc auto

Event OnEffectStart(Actor Target, Actor Caster)
	Actor StepItem
	Actor[] TempArray
	Bool IsSingleFriendly = FALSE
	Int MenuOption
	Int LoopStep = 0
	int RandomNPC =0
	
	(a0aCoreQuest as a0aCoreScript).RegisterForUpdate(5.0)
	(a0aCoreQuest as a0aCoreScript).TargetRef = None	
	CoreLocationRefDummy.MoveTo(Game.GetPlayer())
	
	a0aCoreSpellVoiceMenuActor.Cast(Game.GetPlayer())
	a0aCoreSpellVoiceMenuLocation.Cast(Game.GetPlayer())
	Utility.Wait(0.075)

	Actor TargetRef = (a0aCoreQuest as a0aCoreScript).TargetRef

	;==================================================
	;SET UP MENU SELECTIONS THAT WILL SHOW AND ALL THAT
	;==================================================
	a0aCoreGlobalMenuActor.SetValue(0)
	a0aCoreGlobalMenuLocation.SetValue(0)

	if(Game.GetPlayer().GetDistance(CoreLocationRefDummy) > 64)
		a0aCoreGlobalMenuLocation.SetValue(1)
	endif
	
	if(TargetRef)
		a0aCoreGlobalMenuActor.SetValue(1)
		if(TargetRef.IsPlayerTeammate())
			IsSingleFriendly = True
			a0aCoreGlobalMenuLocation.SetValue(0)
			TempArray = New Actor[1]
			TempArray[0] = TargetRef
		else
			TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
			RandomNPC = utility.randomInt(0, (TempArray.length - 1))
		EndIf
	Else
		TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
	EndIf
	
	
	;=======================
	;SHOW THE MENU SELECTION
	;=======================
;	----------------------------------------------------------------------------
	if((a0aCoreQuestSKSE as a0aCoreQuestSKSEscript).bSKSE)
		int iControl=input.getMappedKey("Activate")
		if(input.isKeypressed(iControl))
			MenuOption=8
		elseif(IsSingleFriendly)
			MenuOption = a0aCoreMessageDialogueMenuSingle.Show()	
		else
			MenuOption = a0aCoreMessageDialogueMenu.Show()
		endif
	else
;	----------------------------------------------------------------------------
		if(IsSingleFriendly)
			MenuOption = a0aCoreMessageDialogueMenuSingle.Show()	
		else
			MenuOption = a0aCoreMessageDialogueMenu.Show()
		endif
	endif
	if(MenuOption==3)
		CoreLocationRef1.MoveTo(CoreLocationRefDummy)
		CoreLocationRef2.MoveTo(CoreLocationRefDummy)
	endif	
	
	While(LoopStep < TempArray.length)
		StepItem=TempArray[LoopStep]
		if(StepItem)
			if(MenuOption==0)
				if(IsSingleFriendly)
					(a0aCoreQuest as a0aCoreScript).FollowerFollowVanguard(StepItem)
				Else
					stepItem.StartCombat(TargetRef)
				EndIf
			elseif(MenuOption==1)
				(a0aCoreQuest as a0aCoreScript).FollowerFollow(StepItem)
			elseif(MenuOption==2)
				(a0aCoreQuest as a0aCoreScript).FollowerWait(StepItem)
			elseif(MenuOption==3)
				(a0aCoreQuest as a0aCoreScript).FollowerWaitLocation(StepItem)
			elseif(MenuOption==4)
				(a0aCoreQuest as a0aCoreScript).FollowerStanceAggressive(StepItem)
			elseif(MenuOption==5)
				(a0aCoreQuest as a0aCoreScript).FollowerStancePassive(StepItem)
			elseif(MenuOption==6)
				(a0aCoreQuest as a0aCoreScript).FollowerAbilityEnable(StepItem)
			elseif(MenuOption==7)
				(a0aCoreQuest as a0aCoreScript).FollowerAbilityDisable(StepItem)
			elseif(MenuOption==8)
				if(loopStep==RandomNPC)
					StepItem.setdoingfavor(TRUE)
				endif
			elseif(MenuOption==9)
				if(IsSingleFriendly)
					Game.GetPlayer().PushActorAway(TargetRef,1)
				EndIf			
			Endif

		endIf
		LoopStep = LoopStep+1
	EndWhile

EndEvent
