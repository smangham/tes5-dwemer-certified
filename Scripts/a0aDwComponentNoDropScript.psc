Scriptname a0aDwComponentNoDropScript extends ObjectReference  
{Prevents inappropriate bots equipping components}

Keyword Property BotKeyword auto
Armor Property BotPlating auto
Weapon Property BotWeapon auto 

Event OnEquipped(Actor akActor)

	if(akActor.HasKeyword(BotKeyword))
	else
		if(BotPlating)
			akActor.UnequipItem(BotPlating,true)
		elseif(BotWeapon)
			akActor.UnequipItem(BotWeapon,true)	
		endif

	endif
endEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(!akNewContainer)
		activate(akOldContainer)
	endif
EndEvent