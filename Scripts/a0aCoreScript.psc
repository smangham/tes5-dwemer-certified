Scriptname a0aCoreScript extends Quest  

Import Debug

Actor Property TargetRef auto
Actor Property HealingRequest Auto
Actor Property OffenceRequest Auto
Actor Property DefenceRequest Auto

Actor[] Property FollowerArray Auto

Spell Property a0aCoreVoiceMenuSpell auto
Faction Property a0aCoreFaction auto
Faction Property a0aCoreFactionHeal auto
Faction Property a0aCoreFactionHealed auto
Faction Property a0aCoreFactionCleanup Auto
Faction Property a0aCoreFactionAbility Auto
Keyword Property a0aCoreKeywordCreature auto
Keyword Property a0aCoreKeywordFollower auto

Quest Property a0aCoreQuest Auto


Event OnInit()
	FollowerArray = New Actor[128]
	RegisterForUpdate(1.0)
EndEvent

Bool bCombat
float fZangle
	
Event OnUpdate()															;Handle NPCs to make sure they're not dead or jammed
	Actor aPlayer = Game.GetPlayer()
		
	if(aPlayer.IsInCombat())
		if(!Game.GetPlayer().IsInFaction(a0aCoreFactionHealed))
			if(Game.GetPlayer().GetAVPercentage("Health")<0.5)
				HealingRequest = game.GetPlayer()
			endif
		endif
		
	elseif(Game.IsFastTravelEnabled())
		Float fDistMax = 2400 - 800*(Game.GetPlayer().IsInInterior() as float)
		Int LoopVar=0
		actor LoopItem
			
		While(LoopVar<FollowerArray.length)
			LoopItem=FollowerArray[LoopVar]
			if(LoopItem)
				if(LoopItem.IsinFaction(a0aCoreFactionCleanup))					;If a follower is dead
					FollowerLeave(LoopItem)									;Cleanup removes them automatically
				Elseif(LoopItem.isDead())										;Up to 10 seconds later
					LoopItem.AddToFaction(a0aCoreFactionCleanup)				;To allow a window for their own scripts to run
				Else
					if(LoopItem.GetAV("WaitingForPlayer")==0)
						if(aPlayer.GetDistance(LoopItem) > fDistMax )
							if(!aPlayer.HasLOS(LoopItem))
								fZangle=aPlayer.getAngleZ()+utility.RandomFloat(-15,15)
								LoopItem.MoveTo(aPlayer,-math.sin(fZangle)*160,-math.cos(fZangle)*160,0,TRUE)
								FollowerFollow(loopItem)
							endif
						endif
					endif
				EndIf
			EndIf
			LoopVar=LoopVar+1
		endwhile
	endif
	
EndEvent

bool Function FollowerJoin(actor FollowerRef, bool bIsCreature = false)
	Int LoopVar = 0
	Bool WasSuccessful = False
	if((FollowerRef as Actor))
		if(!FollowerRef.IsPlayerTeammate())
			Game.GetPlayer().AddSpell(a0aCoreVoiceMenuSpell)
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.SetPlayerTeammate()
			FollowerRef.IgnoreFriendlyHits(true)
			FollowerRef.AddToFaction(a0aCoreFaction)
			
			if(FollowerRef.HasKeyword(a0aCoreKeywordCreature))
				FollowerRef.SetAV("Lockpicking", 0)
			EndIf
			
			While (LoopVar < FollowerArray.length)	
				if(FollowerArray[LoopVar])
					LoopVar = LoopVar +1
				else
					FollowerArray[LoopVar]=FollowerRef
					WasSuccessful = True
					LoopVar = 999
				endif
			EndWhile
		else
			;MessageBox("You have passed Join an invalid NPC!")	
		endif
	
		if(WasSuccessful)
			FollowerFollow(FollowerRef)
		EndIf
	EndIf
	
	Return WasSuccessful
		
EndFunction

Function FollowerLeave(actor FollowerRef)
	Int LoopVar = 0
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate() || FollowerRef.IsDead())
			If(HealingRequest==FollowerRef)
				HealingRequest=None
			EndIf
			FollowerRef.StopCombatAlarm()
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.SetPlayerTeammate(false)
			FollowerRef.SetAV("WaitingForPlayer",0)
			FollowerRef.RemoveFromFaction(a0aCoreFaction)
			
			While (LoopVar < FollowerArray.length)
				if(FollowerArray[LoopVar]==FollowerRef)
					FollowerArray[LoopVar]=None
					LoopVar = 999
				else
					LoopVar = LoopVar +1
				endif
			EndWhile
			FollowerRef.EvaluatePackage()	
		else
			;MessageBox("You have passed Leave an invalid NPC!")
		endif
	EndIf
EndFunction

Function FollowerFollow(actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate())
			FollowerRef.SetAV("WaitingForPlayer",0)
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.EvaluatePackage()
		Else
			;MessageBox("You have passed Follow an invalid NPC!")
		Endif
	EndIf
EndFunction

Function FollowerFollowVanguard(actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate())
			FollowerRef.SetAV("WaitingForPlayer",-1)
			FollowerRef.EvaluatePackage()
			FollowerRef.KeepOffsetFromActor(Game.GetPlayer(),0,768,0)
		Else
			;MessageBox("You have passed Follow Vanguard an invalid NPC!")
		Endif
	EndIf
EndFunction

Function FollowerWait(actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate())
			FollowerRef.SetAV("WaitingForPlayer",1)
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.EvaluatePackage()
		Else
			MessageBox("You have passed Wait an invalid NPC!")
		EndIf
	EndIf
EndFunction

Function FollowerWaitSandbox(actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate())
			FollowerRef.SetAV("WaitingForPlayer",2)
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.EvaluatePackage()
		Else
			;MessageBox("You have passed Wait Sandbox an invalid NPC!")
		Endif
	EndIf
EndFunction

Function FollowerWaitLocation(actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsPlayerTeammate())
			if(FollowerRef.GetAV("WaitingForPlayer")==3)
				FollowerRef.SetAV("WaitingForPlayer",4)
			else
				FollowerRef.SetAV("WaitingForPlayer",3)
			endif
			FollowerRef.ClearKeepOffsetFromActor()
			FollowerRef.EvaluatePackage()
		;Else
			;MessageBox("You have passed Wait Location an invalid NPC!")
		Endif		
	EndIf
EndFunction

Function FollowerStancePassive(Actor FollowerRef)
	if((FollowerRef as Actor))
		FollowerRef.SetAV("Aggression",0)
	EndIf
endFunction

Function FollowerStanceAggressive(Actor FollowerRef)
	if((FollowerRef as Actor))
		FollowerRef.SetAV("Aggression",1)
	EndIf
endFunction

Function FollowerCustom(actor FollowerRef, int NewPackage)
	if((FollowerRef as Actor))
		FollowerRef.SetAV("WaitingForPlayer",NewPackage)
		FollowerRef.ClearKeepOffsetFromActor()
		FollowerRef.EvaluatePackage()
	EndIf
EndFunction

Function FollowerTidyup(Actor FollowerRef)
	if((a0aCoreQuest as a0aCore1SecScript).a0aCoreHealerRef1 == FollowerRef)
		;debug.MessageBox("Follower tidied up! 1")
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing1Alias.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing1Alias.Clear()
	Elseif((a0aCoreQuest as a0aCore1SecScript).a0aCoreHealerRef2 == FollowerRef)
		;debug.MessageBox("Follower tidied up! 2")
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing2Alias.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing2Alias.Clear()
	Elseif((a0aCoreQuest as a0aCore1SecScript).a0aCoreHealerRef3 == FollowerRef)
		;debug.MessageBox("Follower tidied up! 3")
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing3Alias.GetActorReference().RemoveFromFaction(a0aCoreFactionHealed)
		(a0aCoreQuest as a0aCore1SecScript).a0aCoreNeedsHealing3Alias.Clear()
	EndIf
	FollowerFollow(FollowerRef)
EndFunction

Function FollowerMedicStop(Actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsInFaction(a0aCoreFactionHeal))
			FollowerRef.SetFactionRank(a0aCoreFactionHeal,0)
		endif
	EndIf
endFunction

Function FollowerMedicStart(Actor FollowerRef)
	if((FollowerRef as Actor))
		if(FollowerRef.IsInFaction(a0aCoreFactionHeal))
			FollowerRef.SetFactionRank(a0aCoreFactionHeal,1)
		endif
	EndIf
endFunction

Function FollowerAbilityDisable(Actor FollowerRef)
	if(FollowerRef)
		if(FollowerRef.IsInFaction(a0aCoreFactionAbility))
			FollowerRef.SetFactionRank(a0aCoreFactionAbility,0)
		EndIf
	EndIf
	FollowerMedicStop(FollowerRef)
EndFunction

Function FollowerAbilityEnable(Actor FollowerRef)
	if(FollowerRef)
		if(FollowerRef.IsInFaction(a0aCoreFactionAbility))
			FollowerRef.SetFactionRank(a0aCoreFactionAbility,1)
		EndIf
	EndIf
	FollowerMedicStart(FollowerRef)
EndFunction