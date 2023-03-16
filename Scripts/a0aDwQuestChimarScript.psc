Scriptname a0aDwQuestChimarScript extends Quest  
{How Chimarvamidium}

Race Property a0aDwRace5CenturionMantled auto
Armor Property a0aDwSkinBot5Centurion auto
Weapon Property a0aDwWeapBot5CenturionH2H auto
Perk Property crReduceDamage075 auto
Perk Property a0aDwPerkChimar Auto
imageSpaceModifier Property a0aDwChimarImod auto

Shout Property a0aDwShoutChimar Auto
WordOfPower Property a0aDwShoutChimarWord Auto

Race PlayerRace
Actor CenturionRef
Int UpdateTimes =0 

Spell left
Spell right
Spell power
Shout voice
bool ChimarOn


Event OnUpdate()
	if(ChimarOn)
		if(Game.GetPlayer().GetEquippedShout() != a0aDwShoutChimar)
			Game.GetPlayer().EquipShout(a0aDwShoutChimar)
		EndIf
		
		UpdateTimes = UpdateTimes +1
		if(Game.GetPlayer().IsInCombat() && UpdateTimes > 30)
			UpdateTimes = 27
		elseif(UpdateTimes > 30)
			UpdateTimes = 0
			EndChimar()				
		endif
	EndIf
EndEvent

Function BeginChimar(Actor akTarget)
	CenturionRef = akTarget
	a0aDwChimarImod.Apply()
	ChimarOn = True

    Game.SetBeastForm(True)
    Game.EnableFastTravel(False)
    Game.DisablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
    Game.ForceThirdPerson()
	PlayerRace=Game.GetPlayer().GetRace()
	Game.GetPlayer().SetRace(a0aDwRace5CenturionMantled)
	
	Game.GetPlayer().UnequipAll()
	CenturionRef.RemoveItem(a0aDwSkinBot5Centurion,1,false,Game.GetPlayer())
	CenturionRef.RemoveItem(a0aDwWeapBot5CenturionH2H,1,false,Game.GetPlayer())
    Game.GetPlayer().EquipItem(a0aDwSkinBot5Centurion, False, True)
	Game.GetPlayer().EquipItem(a0aDwWeapBot5CenturionH2H, False, True)
	Game.GetPlayer().AddPerk(a0aDwPerkChimar)
	Game.GetPlayer().AddShout(a0aDwShoutChimar)
	Game.UnlockWord(a0aDwShoutChimarWord)
	Game.TeachWord(a0aDwShoutChimarWord)
	Game.GetPlayer().EquipShout(a0aDwShoutChimar)
  
     ; unequip magic
    left = Game.GetPlayer().GetEquippedSpell(0)
    right = Game.GetPlayer().GetEquippedSpell(1)
    power = Game.GetPlayer().GetEquippedSpell(2)
    voice = Game.GetPlayer().GetEquippedShout()
    if (left != None)
        Game.GetPlayer().UnequipSpell(left, 0)
    endif
    if (right != None)
        Game.GetPlayer().UnequipSpell(right, 1)
    endif
    if (power != None)
        Game.GetPlayer().UnequipSpell(power, 2)
    endif
    if (voice != None)
        Game.GetPlayer().UnequipShout(voice)
    endif

	Game.GetPlayer().ResetHealthAndLimbs()

	Game.GetPlayer().MoveTo(CenturionRef,0,0,0,true)

	CenturionRef.disable()
	
	RegisterForUpdate(1.0)
EndFunction

Function EndChimar()
	a0aDwChimarImod.Apply()
	ChimarOn=False
	
    while (Game.GetPlayer().GetAnimationVariableBool("bIsSynced"))
        Utility.Wait(0.1)
    endwhile

	Game.GetPlayer().UnequipItem(a0aDwSkinBot5Centurion, False, True)
	Game.GetPlayer().UnequipItem(a0aDwWeapBot5CenturionH2H, False, True)
	Game.GetPlayer().RemoveItem(a0aDwSkinBot5Centurion,1,true,CenturionRef)
	Game.GetPlayer().RemoveItem(a0aDwWeapBot5CenturionH2H,1,true,CenturionRef)
    Game.GetPlayer().RemovePerk(crReduceDamage075)
	Game.GetPlayer().RemovePerk(a0aDwPerkChimar)
	Game.GetPlayer().RemoveShout(a0aDwShoutChimar)
	
    Game.GetPlayer().SetRace(PlayerRace)
    Game.EnablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abLooking = false, abSneaking = false, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
	
    Game.SetBeastForm(False)
    
	Game.EnableFastTravel(True)
	CenturionRef.MoveTo(Game.GetPlayer(),0,0,0,true)
	CenturionRef.enable()

	UnregisterForUpdate()
EndFunction

