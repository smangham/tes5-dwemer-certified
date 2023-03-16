Scriptname a0aCoreProcedureHealScript extends ObjectReference  

Actor Property Victim Auto
Actor Property Medic Auto
Spell Property a0aCoreSpellHeal Auto
Idle Property MagicRightRelease Auto

Event OnInit()
	if(	Medic.PathToReference(Victim, 1.0) )
		if( Medic.PlayIdleWithTarget(MagicRightRelease, Victim) )
			Cast(Medic, Victim)
		EndIf
	EndIf
EndEvent 