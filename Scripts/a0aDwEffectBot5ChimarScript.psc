Scriptname a0aDwEffectBot5ChimarScript extends ActiveMagicEffect  
{How Chimarvamidium}

Quest Property a0aDwQuest auto
Event OnEffectStart(Actor akTarget, Actor akCaster)
	(a0aDwQuest as a0aDwQuestChimarScript).BeginChimar(akTarget)
EndEvent

