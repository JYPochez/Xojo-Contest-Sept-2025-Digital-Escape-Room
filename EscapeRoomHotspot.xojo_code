#tag Class
Protected Class EscapeRoomHotspot
	#tag Method, Flags = &h0
		Sub Constructor(id As String, x As Integer, y As Integer, radius As Integer, hotspotType As EscapeRoomConstants.eHotspotType)
		  mId = id
		  mX = x
		  mY = y
		  mRadius = radius
		  mType = hotspotType
		  mIsVisible = True
		  mIsActive = True
		  mDescription = ""
		  mRequiredItem = ""
		  mPuzzleId = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContainsPoint(x As Integer, y As Integer) As Boolean
		  // Check if the given point is within the hotspot's radius
		  If Not mIsVisible Or Not mIsActive Then Return False

		  Var distance As Double = Sqrt((x - mX) ^ 2 + (y - mY) ^ 2)
		  Return distance <= mRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Draw hotspot if visible
		  If Not mIsVisible Then Return

		  If mIsActive Then
		    // Active hotspot - yellow highlight
		    g.ForeColor = &cF39C1280 // Yellow with alpha
		    g.FillOval(mX - mRadius, mY - mRadius, mRadius * 2, mRadius * 2)

		    g.ForeColor = &cF39C12
		    g.DrawOval(mX - mRadius, mY - mRadius, mRadius * 2, mRadius * 2)
		  Else
		    // Inactive hotspot - gray highlight
		    g.ForeColor = &c95A5A680 // Gray with alpha
		    g.FillOval(mX - mRadius, mY - mRadius, mRadius * 2, mRadius * 2)

		    g.ForeColor = &c95A5A6
		    g.DrawOval(mX - mRadius, mY - mRadius, mRadius * 2, mRadius * 2)
		  End If
		End Sub
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
		Function GetX() As Integer
		  Return mX
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetY() As Integer
		  Return mY
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRadius() As Integer
		  Return mRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPuzzleId() As String
		  Return mPuzzleId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRequiredItem() As String
		  Return mRequiredItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetType() As EscapeRoomConstants.eHotspotType
		  Return mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsActive() As Boolean
		  Return mIsActive
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsVisible() As Boolean
		  Return mIsVisible
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetActive(active As Boolean)
		  mIsActive = active
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDescription(description As String)
		  mDescription = description
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetPuzzleId(puzzleId As String)
		  mPuzzleId = puzzleId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequiredItem(itemId As String)
		  mRequiredItem = itemId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetVisible(visible As Boolean)
		  mIsVisible = visible
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsVisible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPuzzleId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRadius As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequiredItem As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As EscapeRoomConstants.eHotspotType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mY As Integer
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