Scriptname a0aDwQuestPerkScript extends Quest  
{Handles the NPC stuffs}

Race Property DwarvenSpiderRace auto
Race Property DwarvenSphereRace auto
Race Property DwarvenCenturionRace auto
Race Property a0aDwRace1Spider auto
Race Property a0aDwRace2Sphere auto
Race Property a0aDwRace3Legionary auto
Race Property a0aDwRace3Ballista auto
Race Property a0aDwRace4Simulacra auto
Race Property a0aDwRace5Centurion auto
ActorBase Property a0aDwBot1Spider auto
ActorBase Property a0aDwBot2Sphere auto
ActorBase Property a0aDwBot3Legionary auto
ActorBase Property a0aDwBot3Ballista auto
ActorBase Property a0aDwBot4Simulacra auto
ActorBase Property a0aDwBot5Centurion auto
Keyword Property a0aDwKeyword auto
FormList Property a0aDwListParts1Spider auto
FormList Property a0aDwListParts2Sphere auto
FormList Property a0aDwListParts3Legionary auto
FormList Property a0aDwListParts3Ballista auto
FormList Property a0aDwListParts4Simulacra auto
FormList Property a0aDwListParts5Centurion auto
FormList Property a0aDwListPartsCORES auto
FormList Property a0aDwListPartsBASIC auto
Message Property a0aDwMessagePerkFailPARTS auto
Sound Property NPCDwarvenSphereOpen auto
Sound Property NPCDwarvenSphereDeath auto
EffectShader Property ShockFXShader auto
MiscObject Property a0aDwItemCore2 auto

Function RepairBot(Actor RobotRef)
	Race BotRace = RobotRef.GetRace()
	ActorBase PlaceBot
	bool HasParts = false

	;debug.Messagebox("Beginning repair...")
	
	if(BotRace ==a0aDwRace1Spider || BotRace == DwarvenSpiderRace)
		HasParts = PartsCheck(RobotRef,a0aDwListParts1Spider)
		PlaceBot= a0aDwBot1Spider

	elseif(BotRace ==a0aDwRace2Sphere || BotRace == DwarvenSphereRace)
		HasParts = PartsCheck(RobotRef,a0aDwListParts2Sphere)
		PlaceBot= a0aDwBot2Sphere
	
	elseif(BotRace == a0aDwRace3Legionary)
		HasParts = PartsCheck(RobotRef,a0aDwListParts3Legionary)
		PlaceBot= a0aDwBot3Legionary

	elseif(BotRace == a0aDwRace3Ballista)
		HasParts = PartsCheck(RobotRef,a0aDwListParts3Ballista)
		PlaceBot= a0aDwBot3Ballista

	elseif(BotRace == a0aDwRace4Simulacra)
		HasParts = PartsCheck(RobotRef,a0aDwListParts4Simulacra)
		PlaceBot= a0aDwBot4Simulacra

	elseif(BotRace ==a0aDwRace5Centurion || BotRace == DwarvenCenturionRace)
		HasParts = PartsCheck(RobotRef,a0aDwListParts5Centurion)
		PlaceBot= a0aDwBot5Centurion
	endif

	;ebug.Messagebox("Partscheck says "+HasParts)
	
	if(HasParts)
		
		Actor NewBot = (RobotRef.PlaceAtMe(PlaceBot,1,true) as actor)
		if(RobotRef.HasKeyword(a0aDwKeyword))
			NewBot.RemoveAllItems()
			RobotRef.RemoveItem(a0aDwListPartsCORES,9)
			RobotRef.RemoveAllItems(NewBot)
		endif
		
		RobotRef.setScale(0)
		RobotRef.disable()
		RobotRef.delete()
		
		ShockFXShader.Play(NewBot,1)
		NPCDwarvenSphereOpen.Play(NewBot)
	else
		NPCDwarvenSphereDeath.Play(RobotRef)
		a0aDwMessagePerkFailPARTS.Show()
	endif

EndFunction

bool Function PartsCheck(Actor RobotRef,FormList PartsList)
	bool ValueToReturn = true
	int LoopStep = 0
	Form StepItem

	While(LoopStep < PartsList.GetSize())
		StepItem=PartsList.GetAt(LoopStep)
		if(RobotRef.GetItemCount(StepItem))
		elseif(Game.GetPlayer().GetItemCount(StepItem))
			Game.GetPlayer().RemoveItem(StepItem,1,false,RobotRef)
		else
			ValuetoReturn = false
		endif
		LoopStep = LoopStep+1
	EndWhile

	return ValueToReturn
EndFunction