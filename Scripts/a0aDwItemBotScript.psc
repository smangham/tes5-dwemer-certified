Scriptname a0aDwItemBotScript extends ObjectReference
{Script for spawning bots when item added.}

MiscObject Property DummyBot auto
ActorBase Property PlaceBot auto

Armor Property BotArmor1 auto
Armor Property BotArmor2 auto
Weapon Property BotWeapon1 auto
Weapon Property BotWeapon2 auto

Bool BotPlaced

Event OnInit()
	botPlaced=false
;	if(BotPlaced==false)
;		BotPlaced=true
;		Game.GetPlayer().PlaceAtMe(PlaceBot,1,true)
;		Game.GetPlayer().RemoveItem(DummyBot,1,true)
;	endif
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(akNewContainer == game.GetPlayer())
		BotPlaced=true
		Game.GetPlayer().PlaceAtMe(PlaceBot,1,true)
		Game.GetPlayer().RemoveItem(DummyBot,1,true)	
	endif
EndEvent