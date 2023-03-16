Scriptname a0aCoreItemVoiceMenuLocationScript extends ObjectReference  

Import Debug 

ObjectReference Property CoreLocationRefDummy auto 
float PositionVarX
float PositionVarY
float PositionVarZ

Event OnInit()
	;MessageBox("Running...!")
	CoreLocationRefDummy.MoveTo(Self)
	
	;PositionVarX = GetPositionX()
	;PositionVarY = GetPositionY()
	;PositionVarZ = GetPositionZ()
	
	;MessageBox("Pos are "+PositionVarX+","+PositionVarY+","+PositionVarZ)
	
	;CoreLocationRefDummy.SetPosition(PositionVarX,PositionVarY,PositionVarZ)
	
	Self.Disable()
	Self.Delete()
endEvent