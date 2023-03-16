Scriptname a0aCore1SecScript extends Quest  

Quest Property a0aCoreQuest Auto

ReferenceAlias Property a0aCoreNeedsHealing1Alias Auto
ReferenceAlias Property a0aCoreNeedsHealing2Alias Auto
ReferenceAlias Property a0aCoreNeedsHealing3Alias Auto
Actor Property a0aCoreHealerRef1 Auto
Actor Property a0aCoreHealerRef2 Auto
Actor Property a0aCoreHealerRef3 Auto

Faction Property a0aCoreFactionHeal Auto
Faction Property a0aCoreFactionHealed Auto

Spell Property a0aCoreSpellHeal Auto

Actor [] TempArray
Int TempInt
Actor LoopItem
Int LoopVar = 0

bool CombatState

Event OnInit()
	RegisterForUpdate(1.0)
EndEvent

Event OnUpdate()
	LoopVar= 0
	TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
		
	If(Game.GetPlayer().isinCombat() != CombatState)
		CombatState = Game.GetPlayer().isinCombat() 
		if(!CombatState)
			game.getplayer().removefromfaction(a0aCoreFactionHealed)
			if(a0aCoreHealerRef1)
				(a0aCoreQuest as a0aCoreScript).FollowerFollow(a0aCoreHealerRef1)
				a0aCoreHealerRef1=NONE
			endif
			if(a0aCoreHealerRef2)
				(a0aCoreQuest as a0aCoreScript).FollowerFollow(a0aCoreHealerRef2)
				a0aCoreHealerRef2=NONE
			endif
			if(a0aCoreHealerRef3)
				(a0aCoreQuest as a0aCoreScript).FollowerFollow(a0aCoreHealerRef3)
				a0aCoreHealerRef3=NONE
			endif
			
			if(a0aCoreNeedsHealing1Alias)
				a0aCoreNeedsHealing1Alias.getActorRef().removefromfaction(a0aCoreFactionHealed)
				a0aCoreNeedsHealing1Alias.clear()
			endif
			if(a0aCoreNeedsHealing2Alias)
				a0aCoreNeedsHealing2Alias.getActorRef().removefromfaction(a0aCoreFactionHealed)
				a0aCoreNeedsHealing2Alias.clear()
			endif
			if(a0aCoreNeedsHealing3Alias)
				a0aCoreNeedsHealing3Alias.getActorRef().removefromfaction(a0aCoreFactionHealed)
				a0aCoreNeedsHealing3Alias.clear()
			endif
		endif
	
		While(LoopVar<TempArray.length)
			LoopItem=TempArray[LoopVar]
			if(LoopItem)
				if(loopItem == game.GetPlayer())
					TempArray[LoopVar]=None
				elseif(CombatState)
					LoopItem.ClearKeepOffsetFromActor()
				Elseif(LoopItem.GetActorValue("WaitingForPlayer")==-1)
					(a0aCoreQuest as a0aCoreScript).FollowerFollowVanguard(LoopItem)
				else
					(a0aCoreQuest as a0aCoreScript).FollowerFollow(loopItem)
				EndIf
			EndIf		
		
			LoopVar=LoopVar+1
		EndWhile		
	EndIf
EndEvent
