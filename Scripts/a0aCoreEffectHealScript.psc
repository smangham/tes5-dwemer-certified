Scriptname a0aCoreEffectHealScript extends activemagiceffect  

Faction Property a0aCoreFactionHealed Auto
Quest Property a0aCoreQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.MessageBox("HIT!")
	akTarget.ResetHealthAndLimbs()
	akTarget.RemoveFromFaction(a0aCoreFactionHealed)
	(a0aCoreQuest as a0aCoreScript).FollowerTidyup(akCaster)
EndEvent
