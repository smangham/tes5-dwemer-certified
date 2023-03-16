Scriptname a0aDwEffectPressureScript extends activemagiceffect  

Explosion Property a0aDwExpPressure1 Auto
Explosion Property a0aDwExpPressure2 Auto
Explosion Property a0aDwExpPressure3 Auto
Explosion Property a0aDwExpPressure4 Auto
Explosion Property a0aDwExpPressure5 Auto
Float HealthMax
Float EffMag = 1.25
Float EffDeath = 0.25
Actor BotRef

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForUpdate(0.5)
	BotRef = akTarget
	BotRef.ModActorValue("WeaponSpeedMult",EffMag)
	BotRef.ModActorValue("SpeedMult",EffMag*100)
	HealthMax = BotRef.GetBaseAV("Health")
EndEvent

Event OnUpdate()
	if(BotRef.GetAV("Health")<HealthMax*EffDeath)
		BotRef.Kill(BotRef.GetCombatTarget())
		if((BotRef as a0aDwScriptBot))
			if((BotRef as a0aDwScriptBot).BotTier == 5)
				BotRef.PlaceAtMe(a0aDwExpPressure5,1)
			elseif((BotRef as a0aDwScriptBot).BotTier == 4)
				BotRef.PlaceAtMe(a0aDwExpPressure4,1)
			elseif((BotRef as a0aDwScriptBot).BotTier == 3)
				BotRef.PlaceAtMe(a0aDwExpPressure3,1)
			elseif((BotRef as a0aDwScriptBot).BotTier == 2)
				BotRef.PlaceAtMe(a0aDwExpPressure2,1)
			else
				BotRef.PlaceAtMe(a0aDwExpPressure1,1)		
			EndIf
		Else
			BotRef.PlaceAtMe(a0aDwExpPressure1,1)		
		EndIf
		UnregisterForUpdate()
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	BotRef.ModActorValue("WeaponSpeedMult",-EffMag)
	BotRef.ModActorValue("SpeedMult",-EffMag*100)
EndEvent