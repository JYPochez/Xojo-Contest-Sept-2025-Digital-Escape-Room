#tag Class
Protected Class EscapeRoomGameScene
Inherits GameScene
	#tag Method, Flags = &h0
		Sub Constructor(sceneName As String)
		  // Initialize the game scene
		  Super.Constructor(sceneName)

		  // Initialize game state
		  mCurrentRoom = EscapeRoomConstants.eRoomType.Office
		  mGameState = EscapeRoomConstants.eGameState.Playing
		  mTimeRemaining = EscapeRoomConstants.kTimeLimit
		  mScore = EscapeRoomConstants.kBaseScore
		  mHintsUsed = 0
		  mCurrentRoomNumber = 1
		  mTotalRoomsCompleted = 0
		  ReDim mInventory(-1)
		  ReDim mHotspots(-1)
		  mPuzzles = New Dictionary

		  // Initialize the first room
		  SetupRoom()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Draw background
		  g.ForeColor = &c2C3E50
		  g.FillRectangle(0, 0, 1280, 720)

		  // Draw room background based on current room
		  DrawRoomBackground(g)

		  // Draw hotspots
		  DrawHotspots(g)

		  // Draw UI overlay
		  DrawUI(g)

		  // Draw inventory
		  DrawInventory(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawHotspots(g As Graphics)
		  // Draw all hotspots in current room
		  For Each hotspot As EscapeRoomHotspot In mHotspots
		    hotspot.Draw(g)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawInventory(g As Graphics)
		  // Draw inventory background
		  g.ForeColor = &c34495E80 // Semi-transparent blue
		  Var inventoryWidth As Integer = EscapeRoomConstants.kInventorySlotSize * EscapeRoomConstants.kMaxInventoryItems
		  g.FillRectangle(EscapeRoomConstants.kInventoryX, EscapeRoomConstants.kInventoryY, inventoryWidth, EscapeRoomConstants.kInventorySlotSize)

		  g.ForeColor = &c34495E
		  g.DrawRectangle(EscapeRoomConstants.kInventoryX, EscapeRoomConstants.kInventoryY, inventoryWidth, EscapeRoomConstants.kInventorySlotSize)

		  // Draw inventory items
		  For i As Integer = 0 To mInventory.Count - 1
		    If i >= EscapeRoomConstants.kMaxInventoryItems Then Exit For

		    Var item As EscapeRoomItem = mInventory(i)
		    Var slotX As Integer = EscapeRoomConstants.kInventoryX + (i * EscapeRoomConstants.kInventorySlotSize)
		    Var slotY As Integer = EscapeRoomConstants.kInventoryY

		    // Draw item slot background
		    g.ForeColor = &cECF0F1
		    g.FillRectangle(slotX + 2, slotY + 2, EscapeRoomConstants.kInventorySlotSize - 4, EscapeRoomConstants.kInventorySlotSize - 4)

		    // Draw item name (simplified representation)
		    g.ForeColor = &c2C3E50
		    g.TextSize = 10
		    g.DrawString(item.GetName(), slotX + 5, slotY + 25)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawRoomBackground(g As Graphics)
		  // Draw room-specific background based on room number for enhanced rooms
		  Select Case mCurrentRoomNumber
		  Case 1
		    DrawOfficeBackground(g)
		  Case 2
		    DrawLibraryBackground(g)
		  Case 3
		    DrawLabBackground(g)
		  Case 4
		    DrawBasementBackground(g)
		  Case 5
		    DrawAtticBackground(g)
		  Case 6
		    DrawDeluxeOfficeBackground(g)
		  Case 7
		    DrawAncientLibraryBackground(g)
		  Case 8
		    DrawHighTechLabBackground(g)
		  Case 9
		    DrawDeepBasementBackground(g)
		  Case 10
		    DrawFinalAtticBackground(g)
		  Else
		    // Fallback to basic office
		    DrawOfficeBackground(g)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawOfficeBackground(g As Graphics)
		  // Office room with detailed furniture
		  g.ForeColor = &cF5F5DC // Beige walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Draw floor
		  g.ForeColor = &cD2B48C // Tan wood floor
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw detailed desk
		  DrawOfficeDesk(g, 200, 350)

		  // Draw detailed bookshelf
		  DrawBookshelf(g, 600, 100)

		  // Draw detailed door
		  DrawDoor(g, 1100, 200)

		  // Draw detailed window
		  DrawWindow(g, 100, 150)

		  // Add office details
		  DrawOfficeDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLibraryBackground(g As Graphics)
		  // Library room with detailed furniture
		  g.ForeColor = &cF5DEB3 // Wheat colored walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Draw hardwood floor
		  g.ForeColor = &c8B4513 // Saddle brown floor
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw detailed library furniture
		  DrawLibraryBookshelf(g, 100, 100)
		  DrawReadingDesk(g, 800, 350)
		  DrawAncientTome(g, 400, 200)
		  DrawGlobe(g, 200, 300)
		  DrawDoor(g, 1100, 200)

		  // Add library atmosphere
		  DrawLibraryDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLabBackground(g As Graphics)
		  // Laboratory room with detailed equipment
		  g.ForeColor = &cF0F8FF // Alice blue walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Draw lab floor (white tiles)
		  g.ForeColor = &cF5F5F5 // White smoke floor
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw detailed lab equipment
		  DrawMicroscope(g, 300, 280)
		  DrawChemicalCabinet(g, 600, 200)
		  DrawLabComputer(g, 900, 350)
		  DrawDoor(g, 1100, 200)

		  // Add lab atmosphere
		  DrawLabDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawBasementBackground(g As Graphics)
		  // Basement room with detailed equipment
		  g.ForeColor = &c696969 // Dim gray walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Draw concrete floor
		  g.ForeColor = &c2F4F4F // Dark gray concrete floor
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw detailed basement equipment
		  DrawToolbox(g, 250, 380)
		  DrawFurnace(g, 700, 320)
		  DrawElectricalPanel(g, 500, 180)
		  DrawDoor(g, 1100, 200)

		  // Add basement atmosphere
		  DrawBasementDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAtticBackground(g As Graphics)
		  // Attic room with detailed storage
		  g.ForeColor = &cDEB887 // Burlywood walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Draw wood plank floor
		  g.ForeColor = &cD2B48C // Tan wood floor
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw detailed attic items
		  DrawTrunk(g, 350, 400)
		  DrawMannequin(g, 600, 280)
		  DrawSkylight(g, 200, 130)
		  DrawDoor(g, 1100, 200)

		  // Add attic atmosphere
		  DrawAtticDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDeluxeOfficeBackground(g As Graphics)
		  // Executive office with premium furniture and safe
		  g.ForeColor = &cF8F8FF // Ghost white walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Premium hardwood floor
		  g.ForeColor = &c8B4513 // Saddle brown
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw executive furniture
		  DrawExecutiveDesk(g, 350, 350)
		  DrawWallSafe(g, 120, 200)
		  DrawConferenceTable(g, 650, 300)
		  DrawExecutiveChair(g, 300, 320)
		  DrawDoor(g, 1100, 200)

		  // Add executive atmosphere
		  DrawDeluxeOfficeDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAncientLibraryBackground(g As Graphics)
		  // Mystical library with magical elements
		  g.ForeColor = &c2F4F4F // Dark slate gray walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Ancient stone floor
		  g.ForeColor = &c696969 // Dim gray
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw mystical library furniture
		  DrawMysticalBookshelf(g, 100, 100)
		  DrawSpellTable(g, 800, 350)
		  DrawCrystalOrb(g, 400, 200)
		  DrawMagicPortal(g, 600, 150)
		  DrawDoor(g, 1100, 200)

		  // Add magical atmosphere
		  DrawAncientLibraryDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawHighTechLabBackground(g As Graphics)
		  // Advanced laboratory with futuristic equipment
		  g.ForeColor = &cF0F8FF // Alice blue walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // High-tech floor tiles
		  g.ForeColor = &cC0C0C0 // Silver
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw high-tech equipment
		  DrawQuantumComputer(g, 300, 280)
		  DrawHolographicDisplay(g, 700, 200)
		  DrawRobotArm(g, 500, 350)
		  DrawTechConsole(g, 900, 300)
		  DrawDoor(g, 1100, 200)

		  // Add futuristic atmosphere
		  DrawHighTechLabDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDeepBasementBackground(g As Graphics)
		  // Industrial basement with heavy machinery
		  g.ForeColor = &c2F2F2F // Dark gray walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Concrete floor
		  g.ForeColor = &c808080 // Gray
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw industrial equipment
		  DrawSteamBoiler(g, 200, 300)
		  DrawIndustrialPipes(g, 500, 100)
		  DrawHeavyMachinery(g, 800, 350)
		  DrawElectricalGrid(g, 1000, 200)
		  DrawDoor(g, 1100, 200)

		  // Add industrial atmosphere
		  DrawDeepBasementDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawFinalAtticBackground(g As Graphics)
		  // Epic finale room with treasure and portal
		  g.ForeColor = &cFFD700 // Gold walls
		  g.FillRectangle(50, 50, 1180, 520)

		  // Mystical floor
		  g.ForeColor = &cDDA0DD // Plum
		  g.FillRectangle(50, 450, 1180, 120)

		  // Draw finale elements
		  DrawTreasureChest(g, 350, 400)
		  DrawVictoryPortal(g, 600, 200)
		  DrawAncientAltar(g, 800, 350)
		  DrawMysticalCrystals(g, 200, 300)
		  DrawDoor(g, 1100, 200)

		  // Add victory atmosphere
		  DrawFinalAtticDetails(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawOfficeDesk(g As Graphics, x As Integer, y As Integer)
		  // Draw a detailed office desk
		  // Desk top
		  g.ForeColor = &c8B4513 // Saddle brown
		  g.FillRectangle(x, y, 300, 80)

		  // Desk legs
		  g.ForeColor = &c654321 // Dark brown
		  g.FillRectangle(x + 10, y + 80, 15, 40) // Left front leg
		  g.FillRectangle(x + 275, y + 80, 15, 40) // Right front leg
		  g.FillRectangle(x + 10, y + 60, 15, 40) // Left back leg
		  g.FillRectangle(x + 275, y + 60, 15, 40) // Right back leg

		  // Drawers
		  g.ForeColor = &c696969 // Gray drawer fronts
		  g.FillRectangle(x + 20, y + 10, 80, 25)
		  g.FillRectangle(x + 200, y + 10, 80, 25)

		  // Drawer handles
		  g.ForeColor = &c2F4F4F // Light gray
		  g.FillOval(x + 55, y + 20, 8, 8)
		  g.FillOval(x + 235, y + 20, 8, 8)

		  // Computer monitor
		  g.ForeColor = &c000000 // Black
		  g.FillRectangle(x + 120, y - 60, 60, 45)
		  g.ForeColor = &c0000FF // Blue screen
		  g.FillRectangle(x + 125, y - 55, 50, 35)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawBookshelf(g As Graphics, x As Integer, y As Integer)
		  // Draw a detailed bookshelf
		  // Main structure
		  g.ForeColor = &c654321 // Dark brown wood
		  g.FillRectangle(x, y, 150, 400)

		  // Shelves
		  g.ForeColor = &c8B4513 // Lighter brown shelves
		  For i As Integer = 0 To 4
		    g.FillRectangle(x + 5, y + 5 + (i * 75), 140, 8)
		  Next

		  // Books on shelves
		  Var bookColors() As Color = Array(&cFF0000, &c00FF00, &c0000FF, &cFFFF00, &cFF00FF, &c00FFFF, &cFFA500, &c800080)
		  For shelf As Integer = 0 To 3
		    Var bookX As Integer = x + 10
		    For book As Integer = 0 To 7
		      g.ForeColor = bookColors(book Mod bookColors.Count)
		      Var bookWidth As Integer = 12 + (book Mod 3) * 3
		      g.FillRectangle(bookX, y + 15 + (shelf * 75), bookWidth, 55)
		      bookX = bookX + bookWidth + 2
		      If bookX > x + 130 Then Exit For book
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDoor(g As Graphics, x As Integer, y As Integer)
		  // Draw a detailed door
		  // Door frame
		  g.ForeColor = &c8B4513 // Brown frame
		  g.FillRectangle(x - 5, y - 10, 90, 220)

		  // Door itself
		  g.ForeColor = &cDEB887 // Burlywood
		  g.FillRectangle(x, y, 80, 200)

		  // Door panels
		  g.ForeColor = &cCD853F // Peru
		  g.DrawRectangle(x + 10, y + 20, 60, 70)
		  g.DrawRectangle(x + 10, y + 110, 60, 70)

		  // Door handle
		  g.ForeColor = &cFFD700 // Gold
		  g.FillOval(x + 60, y + 95, 12, 12)

		  // Keyhole
		  g.ForeColor = &c000000 // Black
		  g.FillOval(x + 64, y + 99, 4, 4)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawWindow(g As Graphics, x As Integer, y As Integer)
		  // Draw a detailed window
		  // Window frame
		  g.ForeColor = &cFFFFFF // White frame
		  g.FillRectangle(x - 5, y - 5, 130, 90)

		  // Window panes
		  g.ForeColor = &c87CEEB // Sky blue
		  g.FillRectangle(x, y, 60, 40)
		  g.FillRectangle(x + 60, y, 60, 40)
		  g.FillRectangle(x, y + 40, 60, 40)
		  g.FillRectangle(x + 60, y + 40, 60, 40)

		  // Window cross bars
		  g.ForeColor = &cF5F5F5 // Light gray
		  g.FillRectangle(x + 57, y, 6, 80) // Vertical
		  g.FillRectangle(x, y + 37, 120, 6) // Horizontal

		  // View outside - simple landscape
		  g.ForeColor = &c32CD32 // Lime green (grass)
		  g.FillRectangle(x + 5, y + 60, 50, 15)
		  g.FillRectangle(x + 65, y + 60, 50, 15)

		  // Clouds
		  g.ForeColor = &cFFFFFF // White clouds
		  g.FillOval(x + 10, y + 5, 15, 10)
		  g.FillOval(x + 80, y + 8, 20, 12)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawOfficeDetails(g As Graphics)
		  // Add office atmosphere details
		  // Ceiling light
		  g.ForeColor = &cFFFFE0 // Light yellow
		  g.FillOval(620, 70, 40, 20)

		  // Wall pictures
		  g.ForeColor = &c8B4513 // Brown frames
		  g.DrawRectangle(300, 100, 60, 40)
		  g.DrawRectangle(800, 120, 50, 35)

		  // Picture contents
		  g.ForeColor = &c32CD32 // Green landscape
		  g.FillRectangle(305, 105, 50, 30)
		  g.ForeColor = &c0000FF // Blue abstract
		  g.FillRectangle(805, 125, 40, 25)

		  // Trash can
		  g.ForeColor = &c808080 // Gray
		  g.FillOval(520, 480, 30, 40)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLibraryBookshelf(g As Graphics, x As Integer, y As Integer)
		  // Draw a tall library bookshelf
		  g.ForeColor = &c654321 // Dark brown wood
		  g.FillRectangle(x, y, 200, 400)

		  // Shelves
		  g.ForeColor = &c8B4513 // Lighter brown shelves
		  For i As Integer = 0 To 5
		    g.FillRectangle(x + 5, y + 5 + (i * 65), 190, 8)
		  Next

		  // Ancient books
		  Var bookColors() As Color = Array(&c8B0000, &c2F4F4F, &c006400, &c4B0082, &c8B4513, &cB22222)
		  For shelf As Integer = 0 To 4
		    Var bookX As Integer = x + 10
		    For book As Integer = 0 To 9
		      g.ForeColor = bookColors(book Mod bookColors.Count)
		      Var bookWidth As Integer = 15 + (book Mod 3) * 3
		      g.FillRectangle(bookX, y + 15 + (shelf * 65), bookWidth, 50)
		      bookX = bookX + bookWidth + 2
		      If bookX > x + 180 Then Exit For book
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawReadingDesk(g As Graphics, x As Integer, y As Integer)
		  // Draw a library reading desk
		  g.ForeColor = &c8B4513 // Saddle brown
		  g.FillRectangle(x, y, 200, 80)

		  // Desk legs
		  g.ForeColor = &c654321 // Dark brown
		  g.FillRectangle(x + 10, y + 80, 15, 40)
		  g.FillRectangle(x + 175, y + 80, 15, 40)

		  // Scrolls and papers
		  g.ForeColor = &cF5DEB3 // Wheat
		  g.FillRectangle(x + 20, y + 10, 40, 60)
		  g.ForeColor = &cFFE4B5 // Moccasin
		  g.FillRectangle(x + 70, y + 15, 50, 30)
		  g.FillRectangle(x + 130, y + 20, 30, 40)

		  // Inkwell
		  g.ForeColor = &c000000 // Black
		  g.FillOval(x + 160, y + 15, 15, 15)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAncientTome(g As Graphics, x As Integer, y As Integer)
		  // Draw an ancient book on a pedestal
		  g.ForeColor = &c8B4513 // Brown pedestal
		  g.FillRectangle(x, y + 80, 80, 100)
		  g.FillRectangle(x + 10, y + 60, 60, 20)

		  // Ancient book
		  g.ForeColor = &c8B0000 // Dark red book
		  g.FillRectangle(x + 20, y + 40, 40, 25)
		  g.ForeColor = &cFFD700 // Gold details
		  g.DrawRectangle(x + 22, y + 42, 36, 21)
		  g.DrawRectangle(x + 24, y + 44, 32, 17)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawGlobe(g As Graphics, x As Integer, y As Integer)
		  // Draw an antique globe
		  g.ForeColor = &c8B4513 // Brown stand
		  g.FillRectangle(x + 30, y + 60, 20, 40)
		  g.FillRectangle(x + 10, y + 95, 60, 10)

		  // Globe sphere
		  g.ForeColor = &c4682B4 // Steel blue oceans
		  g.FillOval(x, y, 80, 80)
		  g.ForeColor = &c32CD32 // Lime green continents
		  g.FillOval(x + 10, y + 15, 25, 20)
		  g.FillOval(x + 45, y + 25, 20, 30)
		  g.FillOval(x + 15, y + 45, 30, 15)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLibraryDetails(g As Graphics)
		  // Add library atmosphere
		  // Chandelier
		  g.ForeColor = &cFFD700 // Gold
		  g.FillOval(620, 70, 40, 20)

		  // Candles
		  g.ForeColor = &cF5DEB3 // Wheat
		  g.FillRectangle(350, 180, 8, 25)
		  g.FillRectangle(480, 160, 8, 25)
		  g.ForeColor = &cFF4500 // Orange red flames
		  g.FillOval(350, 175, 8, 8)
		  g.FillOval(480, 155, 8, 8)

		  // Carpet
		  g.ForeColor = &cB22222 // Fire brick red
		  g.FillRectangle(300, 480, 400, 60)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMicroscope(g As Graphics, x As Integer, y As Integer)
		  // Draw a highly detailed professional microscope

		  // Shadow for depth
		  g.ForeColor = &c404040 // Dark shadow
		  g.FillRectangle(x + 3, y + 83, 100, 40)

		  // Heavy metal base with ribbed texture
		  g.ForeColor = &cC0C0C0 // Silver base
		  g.FillRectangle(x, y + 80, 100, 40)

		  // Base texture details
		  g.ForeColor = &cB0B0B0 // Darker metal ridges
		  For i As Integer = 0 To 9
		    g.DrawRectangle(x + (i * 10), y + 85, 8, 2)
		    g.DrawRectangle(x + (i * 10), y + 105, 8, 2)
		  Next

		  // Support arm - thick and stable
		  g.ForeColor = &c696969 // Dim gray metal
		  g.FillRectangle(x + 40, y, 20, 120)

		  // Arm joint details
		  g.ForeColor = &c2F2F2F // Darker joint
		  g.FillRectangle(x + 35, y + 15, 30, 8)
		  g.FillRectangle(x + 35, y + 65, 30, 8)

		  // Binocular eyepiece assembly
		  g.ForeColor = &c000000 // Black eyepieces
		  g.FillOval(x + 40, y - 8, 8, 12) // Left eyepiece
		  g.FillOval(x + 52, y - 8, 8, 12) // Right eyepiece

		  // Eyepiece tube
		  g.ForeColor = &c2F2F2F // Dark gray tube
		  g.FillRectangle(x + 38, y + 4, 24, 20)

		  // Objective lens turret (rotating nosepiece)
		  g.ForeColor = &cFFD700 // Brass/gold turret
		  g.FillOval(x + 35, y + 50, 30, 30)

		  // Multiple objective lenses at different magnifications
		  g.ForeColor = &c000000 // Black lens bodies
		  g.FillOval(x + 47, y + 55, 6, 8)   // 4x objective
		  g.FillOval(x + 42, y + 65, 6, 8)   // 10x objective
		  g.FillOval(x + 52, y + 65, 6, 8)   // 40x objective
		  g.FillOval(x + 47, y + 72, 6, 8)   // 100x oil objective

		  // Specimen stage with mechanical controls
		  g.ForeColor = &cC0C0C0 // Polished metal stage
		  g.FillRectangle(x + 15, y + 80, 70, 12)

		  // Stage clips for holding slides
		  g.ForeColor = &c404040 // Dark metal clips
		  g.FillRectangle(x + 20, y + 82, 12, 3)
		  g.FillRectangle(x + 68, y + 82, 12, 3)

		  // Glass specimen slide
		  g.ForeColor = &cF0F8FF // Clear glass with blue tint
		  g.FillRectangle(x + 35, y + 84, 20, 6)

		  // Focus adjustment knobs (coarse and fine)
		  g.ForeColor = &c2F4F4F // Light gray knobs
		  g.FillOval(x + 5, y + 40, 15, 15)  // Coarse focus (left)
		  g.FillOval(x + 80, y + 45, 12, 12) // Fine focus (right)

		  // Knob centers and grip texture
		  g.ForeColor = &cFFFFFF // White centers
		  g.FillOval(x + 8, y + 43, 9, 9)
		  g.FillOval(x + 82, y + 47, 8, 8)

		  // Condenser assembly below stage
		  g.ForeColor = &c2F2F2F // Dark metal condenser
		  g.FillRectangle(x + 42, y + 95, 16, 12)

		  // Aperture diaphragm
		  g.ForeColor = &c000000 // Black aperture
		  g.FillOval(x + 47, y + 100, 6, 6)

		  // Built-in illumination
		  g.ForeColor = &cFFFF00 // Bright yellow light
		  g.FillOval(x + 45, y + 110, 10, 8)

		  // Light intensity control
		  g.ForeColor = &c808080 // Gray control dial
		  g.FillOval(x + 85, y + 110, 8, 8)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawChemicalCabinet(g As Graphics, x As Integer, y As Integer)
		  // Draw a chemical storage cabinet
		  g.ForeColor = &cFFFFFF // White cabinet
		  g.FillRectangle(x, y, 150, 250)

		  // Cabinet doors
		  g.ForeColor = &cF5F5F5 // Light gray
		  g.DrawRectangle(x + 5, y + 5, 65, 240)
		  g.DrawRectangle(x + 80, y + 5, 65, 240)

		  // Door handles
		  g.ForeColor = &c696969 // Dim gray
		  g.FillOval(x + 60, y + 125, 8, 8)
		  g.FillOval(x + 85, y + 125, 8, 8)

		  // Chemical bottles visible through glass
		  Var colors() As Color = Array(&cFF0000, &c00FF00, &c0000FF, &cFFFF00, &cFF00FF)
		  For i As Integer = 0 To 4
		    g.ForeColor = colors(i)
		    g.FillRectangle(x + 15 + (i * 12), y + 30, 8, 20)
		    g.FillRectangle(x + 95 + (i * 12), y + 50, 8, 20)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLabComputer(g As Graphics, x As Integer, y As Integer)
		  // Draw a lab computer workstation
		  g.ForeColor = &cC0C0C0 // Silver desk
		  g.FillRectangle(x, y, 150, 80)

		  // Computer monitor
		  g.ForeColor = &c000000 // Black monitor
		  g.FillRectangle(x + 20, y - 80, 80, 60)
		  g.ForeColor = &c008000 // Green screen
		  g.FillRectangle(x + 25, y - 75, 70, 50)

		  // Keyboard
		  g.ForeColor = &c2F4F4F // Dark gray
		  g.FillRectangle(x + 30, y + 50, 60, 20)

		  // Data readouts on screen
		  g.ForeColor = &c00FF00 // Bright green text
		  For i As Integer = 0 To 5
		    g.FillRectangle(x + 30, y - 65 + (i * 8), 40, 2)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawLabDetails(g As Graphics)
		  // Add laboratory atmosphere
		  // Overhead lights
		  g.ForeColor = &cFFFFFF // White lights
		  g.FillRectangle(200, 60, 100, 15)
		  g.FillRectangle(500, 60, 100, 15)
		  g.FillRectangle(800, 60, 100, 15)

		  // Lab bench
		  g.ForeColor = &cC0C0C0 // Silver
		  g.FillRectangle(150, 450, 900, 30)

		  // Warning signs
		  g.ForeColor = &cFFFF00 // Yellow
		  g.FillRectangle(80, 120, 40, 40)
		  g.ForeColor = &c000000 // Black text/symbol
		  g.DrawString("!", 95, 145)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawToolbox(g As Graphics, x As Integer, y As Integer)
		  // Draw a metal toolbox
		  g.ForeColor = &c696969 // Dim gray metal
		  g.FillRectangle(x, y, 120, 80)

		  // Toolbox handle
		  g.ForeColor = &c000000 // Black handle
		  g.FillRectangle(x + 50, y - 10, 20, 15)

		  // Tool compartments
		  g.ForeColor = &c2F4F4F // Darker gray
		  g.FillRectangle(x + 10, y + 10, 100, 20)
		  g.FillRectangle(x + 10, y + 40, 100, 30)

		  // Visible tools
		  g.ForeColor = &cC0C0C0 // Silver tools
		  g.FillRectangle(x + 20, y + 15, 15, 3) // Wrench
		  g.FillRectangle(x + 40, y + 13, 8, 8) // Hammer head
		  g.FillRectangle(x + 42, y + 21, 4, 15) // Hammer handle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawFurnace(g As Graphics, x As Integer, y As Integer)
		  // Draw an old furnace
		  g.ForeColor = &c2F4F4F // Dark gray metal
		  g.FillRectangle(x, y, 150, 130)

		  // Furnace door
		  g.ForeColor = &c000000 // Black door
		  g.FillRectangle(x + 20, y + 40, 80, 60)

		  // Fire visible inside
		  g.ForeColor = &cFF4500 // Orange red
		  g.FillRectangle(x + 30, y + 50, 60, 40)
		  g.ForeColor = &cFFFF00 // Yellow flames
		  g.FillRectangle(x + 40, y + 55, 40, 20)

		  // Furnace pipes
		  g.ForeColor = &c696969 // Gray pipes
		  g.FillRectangle(x + 60, y - 20, 30, 40)
		  g.FillRectangle(x + 60, y - 20, 100, 15)

		  // Control dials
		  g.ForeColor = &cC0C0C0 // Silver
		  g.FillOval(x + 110, y + 80, 20, 20)
		  g.FillOval(x + 110, y + 105, 20, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawElectricalPanel(g As Graphics, x As Integer, y As Integer)
		  // Draw an electrical control panel
		  g.ForeColor = &c696969 // Gray panel
		  g.FillRectangle(x, y, 100, 120)

		  // Panel door
		  g.ForeColor = &c2F4F4F // Darker gray
		  g.FillRectangle(x + 5, y + 5, 90, 110)

		  // Circuit breakers
		  g.ForeColor = &c000000 // Black switches
		  For i As Integer = 0 To 7
		    g.FillRectangle(x + 15 + (i Mod 2) * 30, y + 20 + (i \ 2) * 25, 15, 8)
		  Next

		  // Warning label
		  g.ForeColor = &cFFFF00 // Yellow
		  g.FillRectangle(x + 10, y + 95, 80, 15)
		  g.ForeColor = &c000000 // Black text
		  g.DrawString("DANGER", x + 30, y + 105)

		  // Status lights
		  g.ForeColor = &c00FF00 // Green
		  g.FillOval(x + 75, y + 15, 8, 8)
		  g.ForeColor = &cFF0000 // Red
		  g.FillOval(x + 75, y + 28, 8, 8)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawBasementDetails(g As Graphics)
		  // Add basement atmosphere
		  // Overhead pipes
		  g.ForeColor = &c696969 // Gray pipes
		  g.FillRectangle(100, 80, 800, 20)
		  g.FillRectangle(300, 80, 20, 100)
		  g.FillRectangle(600, 80, 20, 150)

		  // Water stains on walls
		  g.ForeColor = &c2F2F2F // Darker gray stains
		  g.FillRectangle(80, 200, 30, 100)
		  g.FillRectangle(950, 150, 40, 80)

		  // Small windows high up
		  g.ForeColor = &c000000 // Black (night outside)
		  g.FillRectangle(200, 80, 40, 25)
		  g.FillRectangle(600, 80, 40, 25)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTrunk(g As Graphics, x As Integer, y As Integer)
		  // Draw an old storage trunk
		  g.ForeColor = &c8B4513 // Brown wood
		  g.FillRectangle(x, y, 120, 70)

		  // Trunk hardware
		  g.ForeColor = &cB8860B // Dark goldenrod brass
		  g.FillRectangle(x + 10, y + 10, 100, 8) // Top edge
		  g.FillRectangle(x + 10, y + 52, 100, 8) // Bottom edge
		  g.FillRectangle(x + 10, y + 18, 8, 34) // Left edge
		  g.FillRectangle(x + 102, y + 18, 8, 34) // Right edge

		  // Lock and hinges
		  g.ForeColor = &cFFD700 // Gold lock
		  g.FillRectangle(x + 50, y + 30, 20, 15)
		  g.ForeColor = &c000000 // Black keyhole
		  g.FillOval(x + 57, y + 35, 6, 6)

		  // Corner reinforcements
		  g.ForeColor = &cB8860B // Brass corners
		  g.FillRectangle(x + 5, y + 5, 15, 15)
		  g.FillRectangle(x + 100, y + 5, 15, 15)
		  g.FillRectangle(x + 5, y + 50, 15, 15)
		  g.FillRectangle(x + 100, y + 50, 15, 15)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMannequin(g As Graphics, x As Integer, y As Integer)
		  // Draw a dress mannequin
		  g.ForeColor = &cF5DEB3 // Wheat colored form
		  g.FillOval(x + 20, y, 40, 60) // Head/bust area
		  g.FillRectangle(x + 30, y + 60, 20, 80) // Torso
		  g.FillRectangle(x + 25, y + 140, 30, 60) // Hips

		  // Dress or clothing
		  g.ForeColor = &c4B0082 // Indigo dress
		  g.FillRectangle(x + 25, y + 70, 30, 130)

		  // Mannequin base
		  g.ForeColor = &c8B4513 // Brown base
		  g.FillRectangle(x + 10, y + 200, 60, 20)

		  // Arms (simplified)
		  g.ForeColor = &cF5DEB3 // Wheat
		  g.FillRectangle(x + 10, y + 80, 15, 40)
		  g.FillRectangle(x + 55, y + 80, 15, 40)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSkylight(g As Graphics, x As Integer, y As Integer)
		  // Draw a skylight window
		  g.ForeColor = &c8B4513 // Brown frame
		  g.FillRectangle(x - 5, y - 5, 130, 90)

		  // Glass panes (night sky)
		  g.ForeColor = &c191970 // Midnight blue night sky
		  g.FillRectangle(x, y, 60, 40)
		  g.FillRectangle(x + 60, y, 60, 40)
		  g.FillRectangle(x, y + 40, 60, 40)
		  g.FillRectangle(x + 60, y + 40, 60, 40)

		  // Window cross bars
		  g.ForeColor = &c2F4F4F // Dark gray
		  g.FillRectangle(x + 57, y, 6, 80) // Vertical
		  g.FillRectangle(x, y + 37, 120, 6) // Horizontal

		  // Stars in the night sky
		  g.ForeColor = &cFFFFFF // White stars
		  g.FillOval(x + 20, y + 15, 3, 3)
		  g.FillOval(x + 45, y + 25, 2, 2)
		  g.FillOval(x + 80, y + 10, 3, 3)
		  g.FillOval(x + 95, y + 60, 2, 2)
		  g.FillOval(x + 30, y + 55, 2, 2)

		  // Moon
		  g.ForeColor = &cF5F5DC // Beige moon
		  g.FillOval(x + 75, y + 45, 25, 25)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAtticDetails(g As Graphics)
		  // Add attic atmosphere
		  // Wooden beams
		  g.ForeColor = &c654321 // Dark brown beams
		  g.FillRectangle(200, 60, 15, 400)
		  g.FillRectangle(500, 60, 15, 400)
		  g.FillRectangle(800, 60, 15, 400)

		  // Cobwebs
		  g.ForeColor = &cD3D3D3 // Light gray webs
		  g.FillRectangle(180, 70, 40, 2)
		  g.FillRectangle(185, 72, 2, 30)
		  g.FillRectangle(480, 65, 35, 2)
		  g.FillRectangle(490, 67, 2, 25)

		  // Old boxes stacked
		  g.ForeColor = &cD2B48C // Tan boxes
		  g.FillRectangle(900, 380, 80, 60)
		  g.FillRectangle(920, 340, 80, 60)
		  g.FillRectangle(1000, 400, 60, 40)

		  // Dust particles in air (small dots)
		  g.ForeColor = &cF5F5DC // Beige dust
		  g.FillOval(300, 200, 2, 2)
		  g.FillOval(450, 180, 2, 2)
		  g.FillOval(700, 220, 2, 2)
		  g.FillOval(550, 250, 2, 2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawUI(g As Graphics)
		  // Draw timer
		  g.ForeColor = &c2C3E50
		  g.DrawString("Time: " + FormatTime(mTimeRemaining), EscapeRoomConstants.kTimerX, EscapeRoomConstants.kTimerY + 20)

		  // Draw score
		  g.DrawString("Score: " + Str(mScore), EscapeRoomConstants.kTimerX, EscapeRoomConstants.kTimerY + 40)

		  // Draw room progress
		  g.DrawString("Room: " + Str(mCurrentRoomNumber) + "/10", EscapeRoomConstants.kTimerX, EscapeRoomConstants.kTimerY + 60)

		  // Draw hint button
		  g.ForeColor = &c3498DB
		  g.FillRectangle(EscapeRoomConstants.kHintButtonX, EscapeRoomConstants.kHintButtonY, 60, 30)
		  g.ForeColor = &cFFFFFF
		  g.DrawString("Hint", EscapeRoomConstants.kHintButtonX + 15, EscapeRoomConstants.kHintButtonY + 20)

		  // Draw hints used counter
		  g.ForeColor = &c2C3E50
		  Var hintsText As String = "Hints: " + Str(mHintsUsed) + "/" + Str(EscapeRoomConstants.kMaxHints)
		  g.DrawString(hintsText, EscapeRoomConstants.kHintButtonX, EscapeRoomConstants.kHintButtonY + 60)

		  // Draw message area with multi-line support
		  If mCurrentMessage <> "" Then
		    g.ForeColor = &c34495E // Blue background
		    g.FillRectangle(50, 560, 1180, 70)  // Taller message area
		    g.ForeColor = &cFFFFFF // White text
		    g.TextSize = 20  // Slightly smaller to fit more text

		    // Split long messages into two lines
		    Var maxLineLength As Integer = 80
		    If mCurrentMessage.Length <= maxLineLength Then
		      // Single line message
		      g.DrawString(mCurrentMessage, 60, 590)
		    Else
		      // Find a good break point (space) around the middle
		      Var breakPoint As Integer = maxLineLength
		      For i As Integer = maxLineLength DownTo maxLineLength - 20
		        If i > 0 And i < mCurrentMessage.Length And mCurrentMessage.Mid(i, 1) = " " Then
		          breakPoint = i
		          Exit For
		        End If
		      Next

		      // Draw first line
		      Var firstLine As String = mCurrentMessage.Left(breakPoint).Trim
		      g.DrawString(firstLine, 60, 580)

		      // Draw second line
		      Var secondLine As String = mCurrentMessage.Mid(breakPoint + 1).Trim
		      g.DrawString(secondLine, 60, 605)
		    End If
		  End If

		  // Draw inventory area label
		  g.ForeColor = &c2C3E50
		  g.DrawString("Inventory:", 50, 650)

		  // Draw inventory items
		  Var itemX As Integer = 150
		  For i As Integer = 0 To mInventory.Count - 1
		    Var item As EscapeRoomItem = mInventory(i)
		    g.ForeColor = &c3498DB // Blue background for items
		    g.FillRectangle(itemX, 635, 100, 30)  // Moved up to avoid overlap
		    g.ForeColor = &cFFFFFF // White text
		    g.DrawString(item.GetName(), itemX + 5, 655)  // Moved up to avoid overlap
		    itemX = itemX + 110
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FormatTime(seconds As Integer) As String
		  Var minutes As Integer = seconds \ 60
		  Var remainingSeconds As Integer = seconds Mod 60
		  Return Format(minutes, "00") + ":" + Format(remainingSeconds, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleInput(inputData As Dictionary)
		  Try
		    If inputData.HasKey("keyPressed") Then
		      Var key As String = inputData.Value("keyPressed")

		      Select Case key
		      Case "Escape"
		        HandleEscapeKey()
		      Case "h", "H"
		        UseHint()
		      Case "i", "I"
		        ToggleInventory()
		      End Select

		    ElseIf inputData.HasKey("mouseClicked") Then
		      Var mouseX As Integer = inputData.Value("mouseX")
		      Var mouseY As Integer = inputData.Value("mouseY")
		      HandleMouseClick(mouseX, mouseY)
		    End If

		  Catch e As RuntimeException
		    System.DebugLog("EscapeRoomGameScene.HandleInput failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleEscapeKey()
		  // Return to main menu (simplified - no confirmation)
		  ShowMessage("Returning to main menu...")

		  // Clear game scene flag
		  If Window1 <> Nil Then
		    Window1.mInGameScene = False
		  End If
		  Router.SwitchToScene(Router.eGameScene.MainMenu)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleMouseClick(x As Integer, y As Integer)
		  // Check hint button
		  If x >= EscapeRoomConstants.kHintButtonX And x <= EscapeRoomConstants.kHintButtonX + 60 And y >= EscapeRoomConstants.kHintButtonY And y <= EscapeRoomConstants.kHintButtonY + 30 Then
		    UseHint()
		    Return
		  End If

		  // Check hotspot interactions
		  For i As Integer = 0 To mHotspots.Count - 1
		    Var hotspot As EscapeRoomHotspot = mHotspots(i)
		    If hotspot.ContainsPoint(x, y) Then
		      InteractWithHotspot(hotspot.GetId())
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InteractWithHotspot(hotspotId As String)
		  // Find the hotspot being interacted with
		  Var targetHotspot As EscapeRoomHotspot
		  For Each hotspot As EscapeRoomHotspot In mHotspots
		    If hotspot.GetId() = hotspotId Then
		      targetHotspot = hotspot
		      Exit For
		    End If
		  Next

		  If targetHotspot = Nil Then Return

		  // Check if item is required
		  Var requiredItem As String = targetHotspot.GetRequiredItem()
		  If requiredItem <> "" And Not HasItem(requiredItem) Then
		    ShowMessage("Locked", "This appears to be locked. You need to find the right item.")
		    Return
		  End If

		  // Handle hotspot interaction based on type
		  Select Case hotspotId
		  Case "desk_drawer"
		    HandleDeskDrawerInteraction()
		  Case "bookshelf"
		    HandleBookshelfInteraction()
		  Case "door"
		    HandleDoorInteraction()
		  Case "window"
		    HandleWindowInteraction()
		  Case Else
		    ShowMessage("Interaction", targetHotspot.GetDescription())
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupOfficeRoom()
		  // Clear existing hotspots
		  mHotspots.RemoveAll()

		  // Initialize office room hotspots
		  Var deskDrawer As New EscapeRoomHotspot("desk_drawer", 350, 390, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  deskDrawer.SetDescription("A desk drawer that might contain something useful.")
		  mHotspots.Add(deskDrawer)

		  Var bookshelf As New EscapeRoomHotspot("bookshelf", 675, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  bookshelf.SetDescription("A bookshelf filled with various books and documents.")
		  mHotspots.Add(bookshelf)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A locked door leading to another room.")
		  mHotspots.Add(door)

		  Var window As New EscapeRoomHotspot("window", 160, 190, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  window.SetDescription("A window overlooking the courtyard.")
		  mHotspots.Add(window)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupLibraryRoom()
		  // Library room - books and knowledge
		  mHotspots.RemoveAll()

		  Var ancientBook As New EscapeRoomHotspot("ancient_book", 400, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  ancientBook.SetDescription("An ancient tome with mysterious symbols.")
		  mHotspots.Add(ancientBook)

		  Var deskDrawer As New EscapeRoomHotspot("desk_drawer", 950, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  deskDrawer.SetDescription("A desk drawer that might contain something useful.")
		  mHotspots.Add(deskDrawer)

		  Var bookshelf As New EscapeRoomHotspot("bookshelf", 200, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  bookshelf.SetDescription("A tall bookshelf filled with ancient volumes.")
		  mHotspots.Add(bookshelf)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A heavy wooden door to the next chamber.")
		  mHotspots.Add(door)

		  Var globe As New EscapeRoomHotspot("globe", 200, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  globe.SetDescription("An antique globe that might rotate.")
		  mHotspots.Add(globe)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupLaboratoryRoom()
		  // Laboratory room - science and experiments
		  mHotspots.RemoveAll()

		  Var microscope As New EscapeRoomHotspot("microscope", 300, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  microscope.SetDescription("A high-powered microscope with a sample.")
		  mHotspots.Add(microscope)

		  Var chemicalCabinet As New EscapeRoomHotspot("chemical_cabinet", 600, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  chemicalCabinet.SetDescription("A cabinet filled with chemical compounds.")
		  mHotspots.Add(chemicalCabinet)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A metal door leading deeper into the facility.")
		  mHotspots.Add(door)

		  Var computer As New EscapeRoomHotspot("computer", 900, 380, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Keypad)
		  computer.SetDescription("A laboratory computer with encrypted files.")
		  mHotspots.Add(computer)

		  Var deskDrawer As New EscapeRoomHotspot("desk_drawer", 1000, 460, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  deskDrawer.SetDescription("A lab desk drawer that might contain equipment.")
		  mHotspots.Add(deskDrawer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupBasementRoom()
		  // Basement room - dark and mysterious
		  mHotspots.RemoveAll()

		  Var deskDrawer As New EscapeRoomHotspot("desk_drawer", 250, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  deskDrawer.SetDescription("An old toolbox drawer that might contain something useful.")
		  mHotspots.Add(deskDrawer)

		  Var furnace As New EscapeRoomHotspot("furnace", 700, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  furnace.SetDescription("An old furnace that might still work.")
		  mHotspots.Add(furnace)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A heavy door leading to upper levels.")
		  mHotspots.Add(door)

		  Var electricalPanel As New EscapeRoomHotspot("electrical_panel", 500, 200, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Keypad)
		  electricalPanel.SetDescription("An electrical panel with complex wiring.")
		  mHotspots.Add(electricalPanel)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupAtticRoom()
		  // Attic room - storage and secrets
		  mHotspots.RemoveAll()

		  Var deskDrawer As New EscapeRoomHotspot("desk_drawer", 350, 420, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  deskDrawer.SetDescription("An old trunk drawer that might contain something useful.")
		  mHotspots.Add(deskDrawer)

		  Var mannequin As New EscapeRoomHotspot("mannequin", 600, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  mannequin.SetDescription("A dress mannequin with vintage clothing.")
		  mHotspots.Add(mannequin)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A narrow door leading to freedom.")
		  mHotspots.Add(door)

		  Var skylight As New EscapeRoomHotspot("skylight", 200, 150, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  skylight.SetDescription("A skylight showing the night sky.")
		  mHotspots.Add(skylight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupDeluxeOfficeRoom()
		  // Enhanced executive office for room 6
		  mHotspots.RemoveAll()

		  Var executiveDesk As New EscapeRoomHotspot("desk_drawer", 400, 420, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  executiveDesk.SetDescription("An executive desk drawer with premium wood finish.")
		  mHotspots.Add(executiveDesk)

		  Var wallSafe As New EscapeRoomHotspot("wall_safe", 150, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Safe)
		  wallSafe.SetDescription("A sophisticated wall safe behind a painting.")
		  mHotspots.Add(wallSafe)

		  Var conferenceTable As New EscapeRoomHotspot("conference_table", 700, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  conferenceTable.SetDescription("A polished conference table with important documents.")
		  mHotspots.Add(conferenceTable)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A mahogany door leading to the executive wing.")
		  mHotspots.Add(door)

		  Var executiveChair As New EscapeRoomHotspot("executive_chair", 350, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  executiveChair.SetDescription("A luxurious leather executive chair.")
		  mHotspots.Add(executiveChair)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupAncientLibraryRoom()
		  // Enhanced mystical library for room 7
		  mHotspots.RemoveAll()

		  Var spellTable As New EscapeRoomHotspot("desk_drawer", 850, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  spellTable.SetDescription("An ancient spell table with mystical artifacts.")
		  mHotspots.Add(spellTable)

		  Var crystalOrb As New EscapeRoomHotspot("crystal_orb", 400, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  crystalOrb.SetDescription("A glowing crystal orb that pulses with magical energy.")
		  mHotspots.Add(crystalOrb)

		  Var mysticalBookshelf As New EscapeRoomHotspot("bookshelf", 150, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  mysticalBookshelf.SetDescription("Ancient tomes filled with forgotten spells.")
		  mHotspots.Add(mysticalBookshelf)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A mystical portal leading to deeper mysteries.")
		  mHotspots.Add(door)

		  Var magicPortal As New EscapeRoomHotspot("magic_portal", 600, 200, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Keypad)
		  magicPortal.SetDescription("A shimmering portal with arcane symbols.")
		  mHotspots.Add(magicPortal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupHighTechLabRoom()
		  // Enhanced high-tech laboratory for room 8
		  mHotspots.RemoveAll()

		  Var quantumComputer As New EscapeRoomHotspot("desk_drawer", 350, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  quantumComputer.SetDescription("A quantum computer console with advanced controls.")
		  mHotspots.Add(quantumComputer)

		  Var holographicDisplay As New EscapeRoomHotspot("hologram", 700, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Keypad)
		  holographicDisplay.SetDescription("A holographic display showing complex data streams.")
		  mHotspots.Add(holographicDisplay)

		  Var robotArm As New EscapeRoomHotspot("robot_arm", 500, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  robotArm.SetDescription("A sophisticated robotic arm assembly.")
		  mHotspots.Add(robotArm)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A high-security door with biometric scanners.")
		  mHotspots.Add(door)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupDeepBasementRoom()
		  // Enhanced industrial basement for room 9
		  mHotspots.RemoveAll()

		  Var steamBoiler As New EscapeRoomHotspot("desk_drawer", 250, 450, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  steamBoiler.SetDescription("A control panel on the industrial steam boiler.")
		  mHotspots.Add(steamBoiler)

		  Var heavyMachinery As New EscapeRoomHotspot("machinery", 800, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  heavyMachinery.SetDescription("Heavy industrial machinery with warning labels.")
		  mHotspots.Add(heavyMachinery)

		  Var electricalGrid As New EscapeRoomHotspot("electrical_panel", 1000, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Keypad)
		  electricalGrid.SetDescription("A complex electrical control grid.")
		  mHotspots.Add(electricalGrid)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("A reinforced door leading to the final chamber.")
		  mHotspots.Add(door)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupFinalAtticRoom()
		  // Epic finale room for room 10
		  mHotspots.RemoveAll()

		  Var treasureChest As New EscapeRoomHotspot("desk_drawer", 400, 450, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Drawer)
		  treasureChest.SetDescription("A magnificent treasure chest filled with gold and jewels.")
		  mHotspots.Add(treasureChest)

		  Var victoryPortal As New EscapeRoomHotspot("victory_portal", 600, 250, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  victoryPortal.SetDescription("A shimmering portal radiating victory energy.")
		  mHotspots.Add(victoryPortal)

		  Var ancientAltar As New EscapeRoomHotspot("ancient_altar", 800, 400, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Book)
		  ancientAltar.SetDescription("An ancient ceremonial altar with sacred relics.")
		  mHotspots.Add(ancientAltar)

		  Var mysticalCrystals As New EscapeRoomHotspot("crystals", 200, 350, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Switch)
		  mysticalCrystals.SetDescription("Glowing mystical crystals that pulse with power.")
		  mHotspots.Add(mysticalCrystals)

		  Var door As New EscapeRoomHotspot("door", 1140, 300, EscapeRoomConstants.kHotspotRadius, EscapeRoomConstants.eHotspotType.Door)
		  door.SetDescription("The final door - your escape to freedom!")
		  mHotspots.Add(door)
		End Sub
	#tag EndMethod


	#tag Method, Flags = &h21
		Private Sub ToggleInventory()
		  // Toggle inventory visibility - placeholder
		  System.DebugLog("Toggling inventory display")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(deltaTime As Double)
		  // Update game timer
		  If mGameState = EscapeRoomConstants.eGameState.Playing Then
		    mTimeRemaining = mTimeRemaining - 1
		    If mTimeRemaining <= 0 Then
		      mGameState = EscapeRoomConstants.eGameState.Failed
		      ShowGameOver()
		    End If
		  End If

		  // Update message timeout
		  If mMessageTimeout > 0 Then
		    mMessageTimeout = mMessageTimeout - deltaTime
		    If mMessageTimeout <= 0 Then
		      mCurrentMessage = ""
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UseHint()
		  If mHintsUsed >= EscapeRoomConstants.kMaxHints Then
		    System.DebugLog("No more hints available")
		    Return
		  End If

		  mHintsUsed = mHintsUsed + 1
		  mScore = mScore - EscapeRoomConstants.kHintPenalty
		  If mScore < 0 Then mScore = 0

		  // Show context-sensitive hint
		  ShowHint()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHint()
		  Var hintText As String = GetCurrentRoomHint()

		  Var d As New MessageDialog
		  d.Message = "Hint " + Str(mHintsUsed)
		  d.Explanation = hintText
		  d.ActionButton.Caption = "OK"
		  Var button As MessageDialogButton = d.ShowModal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCurrentRoomHint() As String
		  Select Case mCurrentRoom
		  Case EscapeRoomConstants.eRoomType.Office
		    Select Case mHintsUsed
		    Case 1
		      Return "Look for something you can open in the desk area."
		    Case 2
		      Return "Check the bookshelf for hidden compartments."
		    Case 3
		      Return "The window might reveal important information."
		    Case Else
		      Return "Try interacting with the yellow highlighted areas."
		    End Select
		  Case Else
		    Return "Explore your surroundings carefully."
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowGameOver()
		  Var d As New MessageDialog
		  d.Message = "Time's Up!"
		  d.Explanation = "You ran out of time. Final Score: " + Str(mScore)
		  d.ActionButton.Caption = "Try Again"
		  d.CancelButton.Visible = True
		  d.CancelButton.Caption = "Main Menu"

		  Var button As MessageDialogButton = d.ShowModal
		  If button = d.ActionButton Then
		    // Restart game
		    Constructor("game")
		  Else
		    Router.SwitchToScene(Router.eGameScene.MainMenu)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasItem(itemId As String) As Boolean
		  // Check if player has the specified item
		  For Each item As EscapeRoomItem In mInventory
		    If item.GetId() = itemId Then Return True
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowMessage(title As String, message As String)
		  // Display an in-game message
		  mCurrentMessage = title + ": " + message
		  mMessageTimeout = 3.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDeskDrawerInteraction()
		  // Dynamic key finding based on current room
		  Var keyId, keyName As String
		  Select Case mCurrentRoomNumber
		  Case 1
		    keyId = "office_key"
		    keyName = "Office Key"
		  Case 2
		    keyId = "library_key"
		    keyName = "Library Key"
		  Case 3
		    keyId = "lab_key"
		    keyName = "Laboratory Key"
		  Case 4
		    keyId = "basement_key"
		    keyName = "Basement Key"
		  Case 5
		    keyId = "attic_key"
		    keyName = "Attic Key"
		  Case 6
		    keyId = "master_key"
		    keyName = "Master Key"
		  Case 7
		    keyId = "vault_key"
		    keyName = "Vault Key"
		  Case 8
		    keyId = "garden_key"
		    keyName = "Garden Key"
		  Case 9
		    keyId = "tower_key"
		    keyName = "Tower Key"
		  Case 10
		    keyId = "final_key"
		    keyName = "Final Key"
		  Else
		    keyId = "office_key"
		    keyName = "Office Key"
		  End Select

		  If Not HasItem(keyId) Then
		    AddItem(New EscapeRoomItem(keyId, keyName, EscapeRoomConstants.eItemType.Key))
		    PlayKeyUnlockSound()
		    ShowMessage("Found Item", "You found a " + keyName + " in the drawer!")
		  Else
		    ShowMessage("Empty", "The drawer is empty now.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleBookshelfInteraction()
		  // Bookshelf interaction - find a clue
		  ShowMessage("Clue Found", "Between the books, you find a note: ""The safe combination is the number of books on this shelf times two.""")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDoorInteraction()
		  // Door interaction - check for key
		  If HasKey() Then
		    // Successfully used key - advance to next room
		    PlayDoorOpenSound()  // Play door opening sound
		    mTotalRoomsCompleted = mTotalRoomsCompleted + 1
		    mScore = mScore + 1000 + (mTimeRemaining * 10)

		    If mTotalRoomsCompleted >= 10 Then
		      // Completed all 10 rooms - show final victory
		      ShowFinalVictory()
		    Else
		      // Advance to next room
		      PlaySmallWinSound()  // Play room completion sound
		      AdvanceToNextRoom()
		    End If
		  Else
		    ShowMessage("Locked", "The door is locked. You need to find a key.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleWindowInteraction()
		  // Window interaction - get hint about safe
		  ShowMessage("View", "Looking out the window, you can see 12 books clearly visible on the bookshelf's reflection.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddItem(item As EscapeRoomItem)
		  // Add item to inventory if there's space
		  If mInventory.Count < EscapeRoomConstants.kMaxInventoryItems Then
		    mInventory.Add(item)
		  Else
		    ShowMessage("Inventory Full", "Your inventory is full! You cannot carry any more items.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowMessage(message As String)
		  // Display an in-game message for 3 seconds
		  mCurrentMessage = message
		  mMessageTimeout = 3.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasKey() As Boolean
		  // Check if player has the key for current room
		  Select Case mCurrentRoomNumber
		  Case 1
		    Return HasItem("office_key")
		  Case 2
		    Return HasItem("library_key")
		  Case 3
		    Return HasItem("lab_key")
		  Case 4
		    Return HasItem("basement_key")
		  Case 5
		    Return HasItem("attic_key")
		  Case 6
		    Return HasItem("master_key")
		  Case 7
		    Return HasItem("vault_key")
		  Case 8
		    Return HasItem("garden_key")
		  Case 9
		    Return HasItem("tower_key")
		  Case 10
		    Return HasItem("final_key")
		  Else
		    Return False
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AdvanceToNextRoom()
		  mCurrentRoomNumber = mCurrentRoomNumber + 1
		  ShowMessage("Success!", "Room " + Str(mTotalRoomsCompleted) + "/10 completed! Entering room " + Str(mCurrentRoomNumber) + "...")

		  // Reset room state
		  mInventory.RemoveAll()
		  mTimeRemaining = EscapeRoomConstants.kTimeLimit
		  mCurrentRoom = GetRoomTypeForNumber(mCurrentRoomNumber)
		  SetupRoom()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowFinalVictory()
		  PlayVictorySound()  // Play final victory sound
		  ShowMessage("CONGRATULATIONS!", "You have escaped all 10 rooms! You are the ultimate escape room champion!")
		  mGameState = EscapeRoomConstants.eGameState.Completed

		  // Bonus for completing all rooms
		  mScore = mScore + 5000

		  // Return to main menu after 5 seconds
		  // Clear game scene flag
		  If Window1 <> Nil Then
		    Window1.mInGameScene = False
		  End If
		  Router.SwitchToScene(Router.eGameScene.MainMenu)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetRoomTypeForNumber(roomNumber As Integer) As EscapeRoomConstants.eRoomType
		  Select Case roomNumber
		  Case 1
		    Return EscapeRoomConstants.eRoomType.Office
		  Case 2
		    Return EscapeRoomConstants.eRoomType.Library
		  Case 3
		    Return EscapeRoomConstants.eRoomType.Laboratory
		  Case 4
		    Return EscapeRoomConstants.eRoomType.Basement
		  Case 5
		    Return EscapeRoomConstants.eRoomType.Attic
		  Case 6
		    Return EscapeRoomConstants.eRoomType.Office // Deluxe office
		  Case 7
		    Return EscapeRoomConstants.eRoomType.Library // Ancient library
		  Case 8
		    Return EscapeRoomConstants.eRoomType.Laboratory // High-tech lab
		  Case 9
		    Return EscapeRoomConstants.eRoomType.Basement // Deep basement
		  Case 10
		    Return EscapeRoomConstants.eRoomType.Attic // Final attic
		  Else
		    Return EscapeRoomConstants.eRoomType.Office
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupRoom()
		  // Setup the current room with appropriate hotspots
		  mHotspots.RemoveAll()

		  Select Case mCurrentRoomNumber
		  Case 1
		    SetupOfficeRoom()
		  Case 2
		    SetupLibraryRoom()
		  Case 3
		    SetupLaboratoryRoom()
		  Case 4
		    SetupBasementRoom()
		  Case 5
		    SetupAtticRoom()
		  Case 6
		    SetupDeluxeOfficeRoom()
		  Case 7
		    SetupAncientLibraryRoom()
		  Case 8
		    SetupHighTechLabRoom()
		  Case 9
		    SetupDeepBasementRoom()
		  Case 10
		    SetupFinalAtticRoom()
		  End Select
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentRoom As EscapeRoomConstants.eRoomType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameState As EscapeRoomConstants.eGameState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHintsUsed As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHotspots() As EscapeRoomHotspot
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInventory() As EscapeRoomItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPuzzles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScore As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimeRemaining As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageTimeout As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentRoomNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalRoomsCompleted As Integer = 0
	#tag EndProperty


	#tag Method, Flags = &h21
		Private Sub PlayKeyUnlockSound()
		  // Play key unlock sound
		  Try
		    keyUnlock.Play
		  Catch e As RuntimeException
		    System.Beep() // Fallback
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PlayDoorOpenSound()
		  // Play door opening sound
		  Try
		    doorOpen.Play
		  Catch e As RuntimeException
		    System.Beep() // Fallback
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PlaySmallWinSound()
		  // Play small victory sound for room completion
		  Try
		    smallWin.Play
		  Catch e As RuntimeException
		    System.Beep() // Fallback
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PlayVictorySound()
		  // Play final victory sound for completing all rooms
		  Try
		    victory.Play
		  Catch e As RuntimeException
		    System.Beep() // Fallback
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawExecutiveDesk(g As Graphics, x As Integer, y As Integer)
		  // Premium executive desk with realistic details

		  // Desk shadow
		  g.ForeColor = &c404040 // Dark shadow
		  g.FillRectangle(x + 5, y + 5, 350, 100)

		  // Main desk surface - rich mahogany with wood grain
		  g.ForeColor = &c654321 // Dark mahogany base
		  g.FillRectangle(x, y, 350, 100)

		  // Wood grain effect
		  g.ForeColor = &c8B4513 // Lighter wood grain
		  For i As Integer = 0 To 6
		    g.DrawRectangle(x + (i * 50), y + 10, 40, 3)
		    g.DrawRectangle(x + (i * 50), y + 30, 40, 2)
		    g.DrawRectangle(x + (i * 50), y + 60, 40, 3)
		  Next

		  // Desk edge with beveled effect
		  g.ForeColor = &cA0522D // Sienna highlight
		  g.FillRectangle(x, y, 350, 8)
		  g.ForeColor = &c8B4513
		  g.FillRectangle(x + 2, y + 2, 346, 4)

		  // Drawers with realistic handles
		  g.ForeColor = &c5D4E75 // Darker drawer fronts
		  g.FillRectangle(x + 20, y + 20, 80, 60)
		  g.FillRectangle(x + 120, y + 20, 80, 60)
		  g.FillRectangle(x + 220, y + 20, 80, 60)

		  // Drawer handles
		  g.ForeColor = &cFFD700 // Gold handles
		  g.FillRectangle(x + 55, y + 45, 10, 4)
		  g.FillRectangle(x + 155, y + 45, 10, 4)
		  g.FillRectangle(x + 255, y + 45, 10, 4)

		  // Multiple realistic monitors with stands
		  For i As Integer = 0 To 2
		    Var monitorX As Integer = x + 50 + (i * 100)

		    // Monitor stand
		    g.ForeColor = &c2F2F2F // Dark gray stand
		    g.FillRectangle(monitorX + 25, y + 5, 30, 15)
		    g.FillRectangle(monitorX + 35, y - 25, 10, 30)

		    // Monitor bezel
		    g.ForeColor = &c000000 // Black bezel
		    g.FillRectangle(monitorX, y - 50, 80, 65)

		    // Monitor screen with reflection
		    g.ForeColor = &c1E1E1E // Dark screen
		    g.FillRectangle(monitorX + 5, y - 45, 70, 55)

		    // Screen content/reflection
		    g.ForeColor = &c000080 // Blue desktop
		    g.FillRectangle(monitorX + 8, y - 42, 64, 49)

		    // Screen highlight (reflection)
		    g.ForeColor = &cC0C0C0 // Light reflection
		    g.FillRectangle(monitorX + 8, y - 42, 20, 15)
		  Next

		  // Desk accessories - realistic details
		  // Executive pen holder
		  g.ForeColor = &c8B4513 // Wood pen holder
		  g.FillOval(x + 310, y + 25, 25, 25)
		  g.ForeColor = &c654321
		  g.FillOval(x + 312, y + 27, 21, 21)

		  // Pens in holder
		  g.ForeColor = &c0000FF // Blue pen
		  g.FillRectangle(x + 318, y + 15, 2, 15)
		  g.ForeColor = &cFF0000 // Red pen
		  g.FillRectangle(x + 322, y + 18, 2, 12)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawWallSafe(g As Graphics, x As Integer, y As Integer)
		  // Sophisticated wall safe behind painting
		  g.ForeColor = &c8B4513 // Brown frame
		  g.FillRectangle(x, y, 100, 80)
		  g.ForeColor = &c2F2F2F // Dark gray safe
		  g.FillRectangle(x + 10, y + 10, 80, 60)
		  g.ForeColor = &cFFD700 // Gold lock
		  g.FillOval(x + 40, y + 35, 20, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawConferenceTable(g As Graphics, x As Integer, y As Integer)
		  // Large polished conference table
		  g.ForeColor = &c654321 // Dark mahogany
		  g.FillRectangle(x, y, 200, 100)
		  g.ForeColor = &c8B4513 // Lighter highlights
		  g.DrawRectangle(x, y, 200, 100)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawExecutiveChair(g As Graphics, x As Integer, y As Integer)
		  // Luxury leather executive chair
		  g.ForeColor = &c800000 // Dark red leather
		  g.FillRectangle(x, y, 60, 80)
		  g.ForeColor = &cFFD700 // Gold accents
		  g.DrawRectangle(x, y, 60, 80)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDeluxeOfficeDetails(g As Graphics)
		  // Executive office atmosphere
		  g.ForeColor = &cFFD700 // Gold chandelier
		  g.FillOval(620, 70, 40, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMysticalBookshelf(g As Graphics, x As Integer, y As Integer)
		  // Ancient magical bookshelf
		  g.ForeColor = &c8B4513 // Dark wood
		  g.FillRectangle(x, y, 200, 300)

		  // Magical books with glowing spines
		  g.ForeColor = &cFF0000 // Red spells
		  g.FillRectangle(x + 10, y + 20, 15, 40)
		  g.ForeColor = &c0000FF // Blue magic
		  g.FillRectangle(x + 30, y + 20, 15, 40)
		  g.ForeColor = &cFFD700 // Gold ancient texts
		  g.FillRectangle(x + 50, y + 20, 15, 40)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSpellTable(g As Graphics, x As Integer, y As Integer)
		  // Ancient spell crafting table
		  g.ForeColor = &c2F2F2F // Dark stone
		  g.FillRectangle(x, y, 150, 80)
		  g.ForeColor = &cFFD700 // Gold mystical symbols
		  g.FillOval(x + 60, y + 30, 30, 30)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawCrystalOrb(g As Graphics, x As Integer, y As Integer)
		  // Glowing crystal orb
		  g.ForeColor = &c9370DB // Purple crystal
		  g.FillOval(x, y, 60, 60)
		  g.ForeColor = &cFFFFFF // White glow
		  g.FillOval(x + 20, y + 20, 20, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMagicPortal(g As Graphics, x As Integer, y As Integer)
		  // Shimmering magical portal
		  g.ForeColor = &c9370DB // Purple energy
		  g.FillOval(x, y, 100, 150)
		  g.ForeColor = &c00FFFF // Cyan shimmer
		  g.FillOval(x + 20, y + 30, 60, 90)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAncientLibraryDetails(g As Graphics)
		  // Magical atmosphere
		  g.ForeColor = &c9370DB // Purple magical energy
		  g.FillOval(300, 100, 20, 20)
		  g.FillOval(800, 150, 15, 15)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawQuantumComputer(g As Graphics, x As Integer, y As Integer)
		  // Advanced quantum computer
		  g.ForeColor = &c000000 // Black casing
		  g.FillRectangle(x, y, 120, 100)
		  g.ForeColor = &c00FFFF // Cyan quantum displays
		  g.FillRectangle(x + 10, y + 10, 100, 30)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawHolographicDisplay(g As Graphics, x As Integer, y As Integer)
		  // Futuristic holographic display
		  g.ForeColor = &c00FFFF // Cyan hologram
		  g.FillRectangle(x, y, 150, 100)
		  g.ForeColor = &cFFFFFF // White data streams
		  g.DrawRectangle(x + 20, y + 20, 110, 60)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawRobotArm(g As Graphics, x As Integer, y As Integer)
		  // Robotic arm assembly
		  g.ForeColor = &cC0C0C0 // Silver metal
		  g.FillRectangle(x, y, 80, 120)
		  g.ForeColor = &cFF0000 // Red joints
		  g.FillOval(x + 30, y + 20, 20, 20)
		  g.FillOval(x + 30, y + 80, 20, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTechConsole(g As Graphics, x As Integer, y As Integer)
		  // High-tech control console
		  g.ForeColor = &c000000 // Black console
		  g.FillRectangle(x, y, 100, 80)
		  g.ForeColor = &c00FF00 // Green displays
		  g.FillRectangle(x + 10, y + 10, 80, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawHighTechLabDetails(g As Graphics)
		  // Futuristic atmosphere
		  g.ForeColor = &c00FFFF // Cyan energy beams
		  g.DrawRectangle(100, 100, 1080, 300)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSteamBoiler(g As Graphics, x As Integer, y As Integer)
		  // Industrial steam boiler
		  g.ForeColor = &c696969 // Dark gray metal
		  g.FillRectangle(x, y, 150, 200)
		  g.ForeColor = &cFF4500 // Orange flame
		  g.FillRectangle(x + 60, y + 150, 30, 40)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawIndustrialPipes(g As Graphics, x As Integer, y As Integer)
		  // Heavy industrial piping
		  g.ForeColor = &c696969 // Gray pipes
		  g.FillRectangle(x, y, 300, 20)
		  g.FillRectangle(x + 100, y, 20, 100)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawHeavyMachinery(g As Graphics, x As Integer, y As Integer)
		  // Industrial machinery
		  g.ForeColor = &c2F2F2F // Dark machinery
		  g.FillRectangle(x, y, 200, 120)
		  g.ForeColor = &cFFD700 // Gold warning labels
		  g.FillRectangle(x + 80, y + 50, 40, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawElectricalGrid(g As Graphics, x As Integer, y As Integer)
		  // Electrical control grid
		  g.ForeColor = &c000000 // Black panel
		  g.FillRectangle(x, y, 80, 150)
		  g.ForeColor = &cFF0000 // Red warning lights
		  g.FillOval(x + 30, y + 30, 20, 20)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDeepBasementDetails(g As Graphics)
		  // Industrial atmosphere
		  g.ForeColor = &cFF4500 // Orange warning lights
		  g.FillOval(300, 100, 15, 15)
		  g.FillOval(900, 120, 15, 15)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTreasureChest(g As Graphics, x As Integer, y As Integer)
		  // Epic treasure chest
		  g.ForeColor = &c8B4513 // Brown wood
		  g.FillRectangle(x, y, 120, 80)
		  g.ForeColor = &cFFD700 // Gold bands
		  g.FillRectangle(x, y + 20, 120, 10)
		  g.FillRectangle(x, y + 50, 120, 10)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawVictoryPortal(g As Graphics, x As Integer, y As Integer)
		  // Victory portal
		  g.ForeColor = &cFFD700 // Gold energy
		  g.FillOval(x, y, 120, 200)
		  g.ForeColor = &cFFFFFF // White light
		  g.FillOval(x + 30, y + 50, 60, 100)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawAncientAltar(g As Graphics, x As Integer, y As Integer)
		  // Ancient ceremonial altar
		  g.ForeColor = &c696969 // Gray stone
		  g.FillRectangle(x, y, 150, 100)
		  g.ForeColor = &cFFD700 // Gold ceremonial items
		  g.FillOval(x + 60, y + 30, 30, 30)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMysticalCrystals(g As Graphics, x As Integer, y As Integer)
		  // Glowing mystical crystals
		  g.ForeColor = &c9370DB // Purple crystals
		  g.FillRectangle(x, y, 40, 80)
		  g.FillRectangle(x + 60, y + 20, 40, 60)
		  g.ForeColor = &cFFFFFF // White glow
		  g.FillOval(x + 15, y + 30, 10, 10)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawFinalAtticDetails(g As Graphics)
		  // Victory atmosphere
		  g.ForeColor = &cFFD700 // Gold sparkles
		  g.FillOval(200, 150, 10, 10)
		  g.FillOval(500, 180, 10, 10)
		  g.FillOval(800, 120, 10, 10)
		  g.FillOval(1000, 160, 10, 10)
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