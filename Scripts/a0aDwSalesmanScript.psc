Scriptname a0aDwSalesmanScript extends ActiveMagicEffect  

import utility
import form

;===============================================
VisualEffect Property a0aDwSalesmanEyeVFX Auto
VisualEffect Property a0aDwSalesmanVFX Auto
Explosion Property a0aDwSalesmanExp Auto
actor SelfRef

	EVENT OnEffectStart(Actor Target, Actor Caster)	
		selfRef = caster
		a0aDwSalesmanEyeVFX.Play(selfRef, -1)
		a0aDwSalesmanVFX.Play(selfRef,-1)
	ENDEVENT
	
	EVENT onDeath(actor myKiller)
		a0aDwSalesmanVFX.Stop(selfRef)
		a0aDwSalesmanEyeVFX.Stop(selfRef)
		SelfRef.PlaceAtMe(a0aDwSalesmanExp,1)
	ENDEVENT
