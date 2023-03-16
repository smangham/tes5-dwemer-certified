Scriptname a0aDwEffectPerkRepairSpellScript extends activemagiceffect  
{Does what the perk fragment won't.}

Quest Property a0aDwQuest  auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(a0aDwQuest as a0aDwQuestPerkScript).RepairBot(akTarget as Actor)
EndEvent