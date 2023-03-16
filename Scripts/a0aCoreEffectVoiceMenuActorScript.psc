Scriptname a0aCoreEffectVoiceMenuActorScript extends activemagiceffect  

Quest Property a0aCoreQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if(akTarget.isDead())
	Else
		(a0aCoreQuest as a0aCoreScript).TargetRef = akTarget
	EndIf
endEvent