Scriptname a0aDwQuestScript  extends Quest Conditional
{Handles Follow/Wait code}

import Debug

actor[] Property BotArray Auto
bool BotArrayInit = False
bool BotArrayNeedsTransferring = TRUE

Quest Property a0aCoreQuest auto

Message Property a0aDwMessageDialogueWait auto
Message Property a0aDwMessageDialogueFollow auto
Message Property  a0aDwMessageDialogueDeploy Auto
Message Property  a0aDwMessageDialogueFollowFAIL Auto
Message Property a0aDwMessageDialogueFollowCAP Auto
Message Property a0aDwMessageDialoguePassive Auto
Message Property a0aDwMessageDialogueAggressive Auto
Message Property a0aDwMessageDialogueCurrentCap Auto
GlobalVariable Property a0aDwGlobalUpkeep auto
FormList Property a0aDwBotList auto
FormList Property a0aDwListPartsALL auto

Float BotDrain = 0.0
Float BotDrainDiff = 0.0
Int BotCount = 0
Int BotNum = 0

Function RobotDeploy(Actor BotRef, bool bVerbose)
	if((BotRef as Actor))
		if(BotArrayNeedsTransferring)
			TransferBotArray()
		EndIf

		if(BotRef.IsPlayerTeammate()||BotRef.IsDead())
			(a0aCoreQuest as a0aCoreScript).FollowerLeave(BotRef)		
			ModBotCount(BotRef,false)
			if(bVerbose)
				a0aDwMessageDialogueDeploy.Show(BotDrainDiff,-BotDrain)
			endif
		endif
	EndIf
EndFunction

Function RobotWait(Actor BotRef, bool bVerbose)
	if((BotRef as Actor))
		if(BotArrayNeedsTransferring)
			TransferBotArray()
		EndIf
		
		(a0aCoreQuest as a0aCoreScript).FollowerWait(BotRef)
		if(bVerbose)
			a0aDwMessageDialogueCurrentCap.Show(-BotDrain)
		endif
	EndIf
EndFunction

Function RobotStancePassive(Actor BotRef, bool bVerbose)
	if((BotRef as Actor))
		(a0aCoreQuest as a0aCoreScript).FollowerStancePassive(BotRef)
		if(bVerbose)
			a0aDwMessageDialoguePassive.Show()
		endif
	EndIf
endFunction

Function RobotStanceAggressive(Actor BotRef, bool bVerbose)
	if((BotRef as Actor))
		(a0aCoreQuest as a0aCoreScript).FollowerStanceAggressive(BotRef)
		if(bVerbose)
			a0aDwMessageDialogueAggressive.Show()
		endif
	EndIf
endFunction

Function RobotFollow(Actor BotRef,Bool bVerbose)
	if((BotRef as Actor))
		if(BotArrayNeedsTransferring)
			TransferBotArray()
		EndIf
	
		if(BotRef.IsPlayerTeammate())
			(a0aCoreQuest as a0aCoreScript).FollowerFollow(BotRef)		
			if(bVerbose)
				a0aDwMessageDialogueCurrentCap.Show(-BotDrain)
			endif
		elseif(RoomForBot(BotRef,bVerbose))
			if((a0aCoreQuest as a0aCoreScript).FollowerJoin(BotRef,true))
				ModBotCount(BotRef,true)
				if(bVerbose)
					a0aDwMessageDialogueFollow.Show(BotDrainDiff,-BotDrain)
				endif		
			endif
		endif
		BotRef.EvaluatePackage()
	EndIf
EndFunction

Function RobotFollowVanguard(Actor BotRef,Bool bVerbose)
	if((BotRef as Actor))
		if(BotArrayNeedsTransferring)
			TransferBotArray()
		EndIf
		(a0aCoreQuest as a0aCoreScript).FollowerFollowVanguard(BotRef)		
		BotRef.EvaluatePackage()
	Endif
EndFunction

bool Function RoomForBot(Actor BotRef, bool bVerbose = False)
	if(BotArrayNeedsTransferring)
		TransferBotArray()
	EndIf

	int NewCap = BotCount + (BotRef as a0aDwScriptBot).BotTier
	bool ValueToReturn = true

	float NewBotUpkeep = (BotRef as a0aDwScriptBot).BotTier*a0aDwGlobalUpkeep.GetValue()
	float NewUpkeep = a0aDwGlobalUpkeep.GetValue()*(NewCap as float)

	if(Game.GetPlayer().GetBaseAV("Magicka") < NewUpkeep)
		if(bVerbose)
			a0aDwMessageDialogueFollowFAIL.Show(NewBotUpkeep)		
		endif
		ValueToReturn = false
	elseif(BotNum == 128)
		if(bVerbose)
			a0aDwMessageDialogueFollowCAP.Show()
		endif
		ValueToReturn = false
	endif
	
	return ValueToReturn
endFunction

Function ModBotCount(Actor BotRef, bool bFollow)
;	Gets current value, mods it away reducing net Magicka drain to 0, then reevalutes and reapplies magicka drain.
	Int LoopVar = 0
	Actor BotLoop
	Actor[] TempArray
	Float BotDrainOrig = BotDrain
	
	TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
	
	BotDrain = -BotDrain
	Game.GetPlayer().ModAV("Magicka",BotDrain)
	
	BotCount = 0
	BotNum = 0
	LoopVar = 0

	While (LoopVar < TempArray.Length)
		BotLoop = TempArray[LoopVar]
		if(BotLoop)
			BotNum = BotNum +1
			BotCount = BotCount + (BotLoop as a0aDwScriptBot).BotTier
		endif
		LoopVar = LoopVar+1
	EndWhile

	BotDrain =  -(BotCount as float)*(a0aDwGlobalUpkeep.value as float)
	Game.GetPlayer().ModAV("Magicka",BotDrain)
	BotDrainDiff=Math.Abs(BotDrainOrig-BotDrain)
endFunction
		
Function TransferBotArray()
	int LoopVar = 0
	Actor[] TempArray
	
	if(BotArrayInit==FALSE || BotArrayNeedsTransferring == FALSE)
	Else
		Return
	EndIf
	
	TempArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
	BotArrayNeedsTransferring=FALSE
	
	while(LoopVar < TempArray.length)
		TempArray[loopVar]=BotArray[LoopVar]
		LoopVar=LoopVar+1
	endwhile
	
	BotArray = (a0aCoreQuest as a0aCoreScript).FollowerArray
EndFunction
