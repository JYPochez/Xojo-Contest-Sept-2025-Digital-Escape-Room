#tag Class
Protected Class EscapeRoomInstructionsScene
Inherits GameScene
	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor("HowToPlay")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Background
		  g.ForeColor = &c2C3E50
		  g.FillRectangle(0, 0, 1280, 720)

		  // Title
		  g.ForeColor = &cECF0F1
		  g.TextFont = "Arial"
		  g.TextSize = 36
		  g.DrawString(EscapeRoomConstants.kGameTitle + " - How to Play", 350, 70)

		  // Content sections
		  g.TextSize = 16
		  Var objectiveText As String = "Escape from the digital rooms by solving puzzles and finding clues." + EndOfLine + "You have " + Str(EscapeRoomConstants.kTimeLimit \ 60) + " minutes to complete all challenges." + EndOfLine + "Use your wits and observation skills to uncover hidden secrets!"
		  DrawInstructionSection(g, "Objective", 100, 140, objectiveText)

		  Var controlsText As String = "• MOUSE: Click on highlighted yellow areas to interact" + EndOfLine + "• ESC: Pause game / Return to main menu" + EndOfLine + "• H: Use a hint (limited to " + Str(EscapeRoomConstants.kMaxHints) + " hints total)" + EndOfLine + "• I: Toggle inventory display"
		  DrawInstructionSection(g, "Controls", 100, 240, controlsText)

		  Var gameplayText As String = "• Explore each room by clicking on interactive hotspots" + EndOfLine + "• Collect items and clues that will help you progress" + EndOfLine + "• Solve puzzles to unlock new areas and advance" + EndOfLine + "• Combine items from your inventory to create solutions" + EndOfLine + "• Use hints sparingly - they reduce your final score"
		  DrawInstructionSection(g, "Gameplay", 100, 360, gameplayText)

		  Var scoringText As String = "• Base Score: " + Str(EscapeRoomConstants.kBaseScore) + " points" + EndOfLine + "• Time Bonus: +" + Str(EscapeRoomConstants.kTimeBonusMultiplier) + " points per minute remaining" + EndOfLine + "• Hint Penalty: -" + Str(EscapeRoomConstants.kHintPenalty) + " points per hint used" + EndOfLine + "• Puzzle Bonus: Varies by difficulty and speed"
		  DrawInstructionSection(g, "Scoring System", 650, 140, scoringText)

		  Var roomTypesText As String = "• Office: Business documents and desk puzzles" + EndOfLine + "• Library: Book codes and literary clues" + EndOfLine + "• Laboratory: Scientific instruments and formulas" + EndOfLine + "• Basement: Mechanical puzzles and hidden passages" + EndOfLine + "• Attic: Storage mysteries and vintage secrets"
		  DrawInstructionSection(g, "Room Types", 650, 280, roomTypesText)

		  Var tipsText As String = "• Examine everything carefully - details matter" + EndOfLine + "• Take notes of codes and patterns you discover" + EndOfLine + "• Try combining different items in your inventory" + EndOfLine + "• Think logically about how objects might be used" + EndOfLine + "• Don't rush - methodical exploration pays off"
		  DrawInstructionSection(g, "Tips for Success", 650, 420, tipsText)

		  // Navigation hint
		  g.ForeColor = &c3498DB
		  g.TextSize = 18
		  g.DrawString("Press any key or click to return to the main menu", 350, 650)

		  // Grid pattern background (subtle)
		  DrawBackgroundGrid(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawBackgroundGrid(g As Graphics)
		  g.ForeColor = &c34495E40 // Very subtle blue
		  For x As Integer = 0 To 1280 Step 40
		    g.DrawLine(x, 0, x, 720)
		  Next
		  For y As Integer = 0 To 720 Step 40
		    g.DrawLine(0, y, 1280, y)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawInstructionSection(g As Graphics, title As String, x As Integer, y As Integer, content As String)
		  // Section title
		  g.ForeColor = &cF39C12 // Orange
		  g.TextSize = 20
		  g.DrawString(title, x, y)

		  // Section content
		  g.ForeColor = &cECF0F1 // Light gray
		  g.TextSize = 14

		  Var lines() As String = content.Split(EndOfLine)
		  For i As Integer = 0 To lines.Count - 1
		    g.DrawString(lines(i), x, y + 30 + (i * 20))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleInput(inputData As Dictionary)
		  // Handle instructions input - return to main menu on any input
		  Try
		    System.DebugLog("EscapeRoomInstructionsScene.HandleInput called")

		    If inputData.HasKey("keyPressed") Then
		      Var keyCode As String = inputData.Value("keyPressed")
		      System.DebugLog("Instructions scene - key pressed: " + keyCode)
		      // Any key returns to main menu
		      Router.SwitchToScene(Router.eGameScene.MainMenu)
		    End If

		    If inputData.HasKey("mouseClicked") Then
		      System.DebugLog("Instructions scene - mouse clicked")
		      // Any mouse click returns to menu
		      Router.SwitchToScene(Router.eGameScene.MainMenu)
		    End If

		  Catch e As RuntimeException
		    System.DebugLog("Error in EscapeRoomInstructionsScene.HandleInput: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(deltaTime As Double)
		  // No updates needed for static instruction screen
		End Sub
	#tag EndMethod


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