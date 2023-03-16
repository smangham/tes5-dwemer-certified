Scriptname a0aDwScriptBot extends Actor

Quest Property a0aDwQuest auto
FormList Property BotFilter auto
int Property BotTier auto

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	(a0aDwQuest as a0aDwQuestEventScript).BotCombat(self,akTarget,aeCombatState)
endEvent

Event OnDeath(Actor akKiller)
	(a0aDwQuest as a0aDwQuestEventScript).BotDead(self,akKiller)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Keyword BotKeyword = (BotFilter.GetAt(0) as keyword)

	if(akBaseItem.HasKeyword(BotKeyword))
		self.EquipItem(akBaseItem)
	else
		self.UnEquipItem(akBaseItem,true)
	endif
endEvent

Function PartsMenu(bool bInstall)
	self.UnequipAll()
	self.ShowGiftMenu(bInstall,BotFilter,true)
EndFunction