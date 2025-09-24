#tag Class
Protected Class EscapeRoomItem
	#tag Method, Flags = &h0
		Sub Constructor(id As String, name As String, itemType As EscapeRoomConstants.eItemType)
		  mId = id
		  mName = name
		  mType = itemType
		  mDescription = ""
		  mIsUsable = True
		  mUsesRemaining = 1
		  mCanCombine = False
		  mCombinesWith = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanCombineWith(otherItemId As String) As Boolean
		  If Not mCanCombine Then Return False
		  Return mCombinesWith.IndexOf(otherItemId) >= 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDescription() As String
		  Return mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetId() As String
		  Return mId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetName() As String
		  Return mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetType() As EscapeRoomConstants.eItemType
		  Return mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUsesRemaining() As Integer
		  Return mUsesRemaining
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsUsable() As Boolean
		  Return mIsUsable And mUsesRemaining > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCanCombine(canCombine As Boolean, combinesWith As String = "")
		  mCanCombine = canCombine
		  mCombinesWith = combinesWith
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDescription(description As String)
		  mDescription = description
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetUsable(usable As Boolean)
		  mIsUsable = usable
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetUses(uses As Integer)
		  mUsesRemaining = uses
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseItem() As Boolean
		  // Use the item and return success
		  If Not IsUsable() Then Return False

		  mUsesRemaining = mUsesRemaining - 1
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCanCombine As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCombinesWith As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsUsable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As EscapeRoomConstants.eItemType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsesRemaining As Integer
	#tag EndProperty


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
End Class
#tag EndClass