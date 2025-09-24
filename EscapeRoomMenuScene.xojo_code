#tag Class
Protected Class EscapeRoomMenuScene
Inherits GameScene
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialize Digital Escape Room Main Menu Scene
		  Super.Constructor("EscapeRoomMenu")

		  // Initialize menu properties
		  mTitle = EscapeRoomConstants.kGameTitle
		  mSubtitle = "Can you escape the locked room?"
		  mSelectedOption = 0

		  // Initialize menu options array
		  ReDim mMenuOptions(-1)
		  mMenuOptions.Add("Start New Escape")
		  mMenuOptions.Add("How to Play")
		  mMenuOptions.Add("Exit")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cleanup()
		  // Clean up menu scene resources
		  mMenuOptions.RemoveAll()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Draw main menu UI
		  Try
		    // Draw background
		    g.ForeColor = &c28283C // Dark blue background
		    g.FillRectangle(0, 0, 1280, 720)

		    // Draw title
		    g.ForeColor = &cFFFFFF // White
		    g.TextFont = "Arial"
		    g.TextSize = 48
		    g.DrawString("Digital Escape Room", 420, 150)

		    // Draw subtitle
		    g.TextSize = 20
		    g.ForeColor = &cC8C8C8 // Light gray
		    g.DrawString("Can you escape the locked room?", 480, 200)

		    // Draw menu options
		    g.TextSize = 28
		    Var options() As String = Array("Start New Escape", "How to Play", "Exit")
		    For i As Integer = 0 To options.Count - 1
		      If i = mSelectedOption Then
		        g.ForeColor = &cFFD700 // Gold for selected
		      Else
		        g.ForeColor = &cC8C8C8 // Light gray for normal
		      End If
		      g.DrawString(options(i), 520, 300 + (i * 50))
		    Next

		    // Draw instructions
		    g.ForeColor = &c808080 // Gray
		    g.TextSize = 16
		    g.DrawString("Use arrow keys to navigate, Enter to select, ESC to exit", 420, 550)

		    // Draw version info
		    g.TextSize = 14
		    g.DrawString("Digital Escape Room v1.0 - Contest Entry September 2025", 850, 700)

		  Catch e As RuntimeException
		    // Error in drawing routine
		  End Try
		End Sub
	#tag EndMethod


	#tag Method, Flags = &h0
		Sub HandleInput(inputData As Dictionary)
		  // Handle menu navigation and selection
		  Try
		    If inputData.HasKey("keyPressed") Then
		      Var keyCode As String = inputData.Value("keyPressed")

		      Select Case keyCode
		      Case Chr(28), Chr(30) // Up arrow key codes
		        // Navigate up
		        mSelectedOption = mSelectedOption - 1
		        If mSelectedOption < 0 Then mSelectedOption = 2

		      Case Chr(29), Chr(31) // Down arrow key codes
		        // Navigate down
		        mSelectedOption = mSelectedOption + 1
		        If mSelectedOption > 2 Then mSelectedOption = 0

		      Case Chr(13), Chr(3), " " // Enter, Return, Space
		        // Select current option
		        HandleMenuSelection()

		      Case Chr(27) // Escape key
		        // Exit game
		        Quit()

		      End Select
		    End If

		    If inputData.HasKey("mouseClicked") Then
		      Var mouseX As Integer = inputData.Value("mouseX")
		      Var mouseY As Integer = inputData.Value("mouseY")
		      HandleMouseClick(mouseX, mouseY)
		    End If

		  Catch e As RuntimeException
		    // Error handling input
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleMenuSelection()
		  // Handle menu option selection
		  Select Case mSelectedOption
		  Case 0 // Start New Escape
		    StartGame()
		  Case 1 // How to Play
		    ShowHowToPlay()
		  Case 2 // Exit
		    Quit()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleMouseClick(x As Integer, y As Integer)
		  // Handle mouse clicks on menu options
		  Var startY As Integer = 300
		  Var lineHeight As Integer = 50  // Match drawing spacing

		  For i As Integer = 0 To mMenuOptions.LastIndex
		    Var optionY As Integer = startY + (i * lineHeight)
		    // Check both X and Y coordinates for better click detection
		    If x >= 420 And x <= 860 And y >= optionY - 25 And y <= optionY + 25 Then
		      mSelectedOption = i
		      HandleMenuSelection()
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  // Initialize menu scene
		  // Clear any scene flags to ensure proper input routing
		  If Window1 <> Nil Then
		    Window1.mInInstructionsScene = False
		    Window1.mInGameScene = False
		  End If

		  // Ensure menu options are properly initialized
		  ReDim mMenuOptions(-1)
		  mMenuOptions.Add("Start New Escape")
		  mMenuOptions.Add("How to Play")
		  mMenuOptions.Add("Exit")

		  // Reset selected option
		  mSelectedOption = 0

		  SetInitialized(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHowToPlay()
		  // Navigate to How to Play scene
		  System.DebugLog("EscapeRoomMenuScene: Switching to How to Play scene")

		  // Set flag for Window1 to handle input directly
		  If Window1 <> Nil Then
		    Window1.mInInstructionsScene = True
		  End If

		  Router.SwitchToScene(Router.eGameScene.HowToPlay)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartGame()
		  // Start new escape room game
		  System.DebugLog("EscapeRoomMenuScene: Switching to game scene")

		  // Set flag for Window1 to handle input directly
		  If Window1 <> Nil Then
		    Window1.mInGameScene = True
		  End If

		  Router.SwitchToScene(Router.eGameScene.GamePlay)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(deltaTime As Double)
		  // Update menu scene (animations, etc.)
		  Try
		    // Could add menu animations here if desired
		    // For now, just update the base scene
		  Catch e As RuntimeException
		    // Error in update cycle
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMenuOptions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNormalColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedOption As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubtitle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitleColor As Color
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