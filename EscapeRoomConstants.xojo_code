#tag Module
Protected Module EscapeRoomConstants
	#tag Constant, Name = kGameTitle, Type = String, Dynamic = False, Default = \"Digital Escape Room", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kGameVersion, Type = String, Dynamic = False, Default = \"v1.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kMaxInventoryItems, Type = Integer, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kMaxHints, Type = Integer, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kTimeLimit, Type = Integer, Dynamic = False, Default = \"600", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kBaseScore, Type = Integer, Dynamic = False, Default = \"1000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kTimeBonusMultiplier, Type = Integer, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kHintPenalty, Type = Integer, Dynamic = False, Default = \"100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kHotspotRadius, Type = Integer, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kInventorySlotSize, Type = Integer, Dynamic = False, Default = \"50", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kInventoryX, Type = Integer, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kInventoryY, Type = Integer, Dynamic = False, Default = \"650", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kTimerX, Type = Integer, Dynamic = False, Default = \"950", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kTimerY, Type = Integer, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kHintButtonX, Type = Integer, Dynamic = False, Default = \"1200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kHintButtonY, Type = Integer, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = eRoomState, Type = Integer, Flags = &h0
		Locked
		InProgress
		Completed
		TimeOut
	#tag EndEnum


	#tag Enum, Name = ePuzzleType, Type = Integer, Flags = &h0
		CodeLock
		DragDrop
		Pattern
		Sequence
		Hidden
	#tag EndEnum


	#tag Enum, Name = ePuzzleState, Type = Integer, Flags = &h0
		Locked
		Available
		Solved
	#tag EndEnum


	#tag Enum, Name = eItemType, Type = Integer, Flags = &h0
		Key
		Tool
		Clue
		Component
		Usable
	#tag EndEnum


	#tag Enum, Name = eHotspotType, Type = Integer, Flags = &h0
		Door
		Drawer
		Painting
		Safe
		Computer
		Book
		Switch
		Keypad
	#tag EndEnum


	#tag Enum, Name = eRoomType, Type = Integer, Flags = &h0
		Office
		Library
		Laboratory
		Basement
		Attic
	#tag EndEnum


	#tag Enum, Name = eGameState, Type = Integer, Flags = &h0
		MainMenu
		Playing
		Paused
		Completed
		Failed
		Instructions
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule