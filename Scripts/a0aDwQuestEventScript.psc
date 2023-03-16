Scriptname a0aDwQuestEventScript extends Quest  
{Hooked by NPC events.}

Spell Property a0aDwSpellAddonCoreSupercooled auto
Armor Property a0aDwAddonCoreFrost auto
Quest Property a0aDwQuest auto
Message Property a0aDwMessageDead auto

Function BotDead(Actor BotRef, Actor BotKiller)
	a0aDwMessageDead.Show()
	(a0aDwQuest as a0aDwQuestScript).RobotDeploy(BotRef,true)
EndFunction


Function BotCombat(Actor BotRef, Actor BotTarg, Int CombatType)
	if (CombatType== 0)
		BotRef.dispelSpell(a0aDwSpellAddonCoreSupercooled)
		BotRef.ResetHealthAndLimbs()
		BotRef.PlaySubGraphAnimation("ActionIdle")
	elseif(CombatType== 1)
		if(BotRef.IsEquipped(a0aDwAddonCoreFrost))
			a0aDwSpellAddonCoreSupercooled.cast(BotRef)
		endif
	endIf

EndFunction