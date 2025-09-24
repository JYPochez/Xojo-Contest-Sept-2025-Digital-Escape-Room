# Digital Escape Room - Developer Documentation

## Application Architecture

### Project Structure
```
Digital Escape Room.xojo_project
├── App.xojo_code (Module)
├── Window1.xojo_window (Main Window)
├── EscapeRoomMenuScene.xojo_code (Class)
├── EscapeRoomGameScene.xojo_code (Class)
├── EscapeRoomInstructionsScene.xojo_code (Class)
├── EscapeRoomHotspot.xojo_code (Class)
├── EscapeRoomItem.xojo_code (Class)
├── EscapeRoomConstants.xojo_code (Module)
├── MainMenuBar.xojo_menu (Menu Bar)
├── Build Automation.xojo_code (Build Settings)
├── key_unlock.mp3 (Sound Resource)
├── door_open.mp3 (Sound Resource)
├── small_win.mp3 (Sound Resource)
└── victory.mp3 (Sound Resource)
```

### Framework Dependencies
This application uses the **Shared Foundations** framework located at `../Shared Foundations/`:
- GameScene (Base class for all scenes)
- Router (Scene management and navigation)
- AppTemplate (Application lifecycle management)
- CanvasManager (Double-buffered rendering)

## Core Classes and Components

### App (Module)
Main application entry point and global state management.

```xojo
Sub Open()
  // Application startup, initialize shared systems
```

### Window1 (Main Window)
Primary game window containing the canvas and handling all input.

**Properties:**
- `mCanvasManager As CanvasManager` - Double buffering manager
- `mUseSimpleMode As Boolean` - Fallback rendering mode flag
- `mInInstructionsScene As Boolean` - Workaround flag for instructions input
- `mInGameScene As Boolean` - Workaround flag for game scene input

**Key Events:**
```xojo
Sub Opening()
  // Initialize AppTemplate and register scenes
  // Create CanvasManager for double buffering
  // Setup all game scenes and switch to main menu

Function KeyDown(key As String) As Boolean
  // Route keyboard input to current scene via Router
  // Special handling for instructions scene workaround

Function MouseDown(x As Integer, y As Integer) As Boolean
  // Route mouse input to current scene via Router
```

**Canvas Events:**
```xojo
Sub GameCanvas.Paint(g As Graphics, areas() As Rect)
  // Render current frame using double buffering
  // Fallback to direct rendering if CanvasManager fails

Sub GameTimer.Action()
  // 60 FPS update loop
  // Calculate deltaTime and update current scene
```

### EscapeRoomMenuScene (Class - extends GameScene)
Main menu scene with navigation options.

**Properties:**
- `mMenuOptions() As String` - Array of menu choices
- `mSelectedOption As Integer` - Currently highlighted option
- `mTitle As String` - Game title text
- `mSubtitle As String` - Subtitle text

**Methods:**
```xojo
Sub Constructor()
  // Initialize menu scene with "Start New Escape", "How to Play", "Exit"

Sub Init()
  // Reinitialize menu options array and reset selected option
  // Critical for fixing mouse click navigation bug

Sub Draw(g As Graphics)
  // Render dark blue background with title and menu options
  // Highlight selected option in gold, others in light gray

Sub HandleInput(inputData As Dictionary)
  // Process arrow key navigation and Enter/Space selection
  // Process mouse clicks on menu options
  // Route to appropriate scene based on selection

Private Sub HandleMenuSelection()
  // Execute action for currently selected menu option

Private Sub HandleMouseClick(x As Integer, y As Integer)
  // Check mouse coordinates against menu option positions
  // Select and activate clicked menu option

Private Sub ShowHowToPlay()
  // Switch to instructions scene and set workaround flag

Private Sub StartGame()
  // Switch to main game scene and set workaround flag
```

### EscapeRoomGameScene (Class - extends GameScene)
Main gameplay scene with 10-room progression system and enhanced graphics.

**Properties:**
- `mHotspots() As EscapeRoomHotspot` - Array of interactive areas
- `mInventory() As EscapeRoomItem` - Player's collected items
- `mCurrentRoom As Integer` - Current room number (1-10)
- `mGameState As EscapeRoomConstants.eGameState` - Overall game progress
- `mScore As Integer` - Current player score
- `mTimeRemaining As Double` - Countdown timer
- `mCurrentMessage As String` - Message display text
- `mHasKey As Boolean` - Current room key possession status
- `mRoomCompleted As Boolean` - Current room completion status

**Methods:**
```xojo
Sub Constructor(sceneName As String)
  // Initialize game scene and setup first room

Sub Draw(g As Graphics)
  // Render room background with detailed graphics for current room type
  // Draw realistic furniture and environmental elements
  // Draw all hotspots with yellow highlighting
  // Display inventory, score, timer, and current message

Sub HandleInput(inputData As Dictionary)
  // Process mouse clicks on hotspots
  // Handle keyboard shortcuts (H for hints, I for inventory, ESC for menu)

Sub Update(deltaTime As Double)
  // Update timer countdown
  // Process hotspot animations and state changes

Private Sub SetupCurrentRoom()
  // Initialize current room (1-10) with appropriate hotspots and theme

Private Sub HandleHotspotClick(hotspot As EscapeRoomHotspot)
  // Process interaction with clicked hotspot
  // Add items to inventory, solve puzzles, advance game state
  // Play sound effects for key interactions

Private Sub HandleDoorInteraction()
  // Check for key possession and advance to next room
  // Play door opening sound and victory sound for final room

Private Sub DrawRoomBackground(g As Graphics)
  // Render detailed realistic graphics for current room type
  // Enhanced themes: Executive Office, Medieval Library, Modern Lab, etc.

Private Sub PlaySound(soundName As String)
  // Play appropriate sound effect for game events
```

### EscapeRoomInstructionsScene (Class - extends GameScene)
How to Play information screen.

**Methods:**
```xojo
Sub Constructor()
  // Initialize instructions scene

Sub Draw(g As Graphics)
  // Render comprehensive how-to-play information
  // Display objective, controls, gameplay, scoring, room types, and tips

Sub HandleInput(inputData As Dictionary)
  // Return to main menu on any input (with Router workaround)
```

### EscapeRoomHotspot (Class)
Individual interactive area within the game room.

**Properties:**
- `mID As String` - Unique hotspot identifier
- `mX As Integer` - X coordinate position
- `mY As Integer` - Y coordinate position
- `mRadius As Integer` - Interaction radius
- `mType As EscapeRoomConstants.eHotspotType` - Type of hotspot
- `mDescription As String` - Examination text
- `mRequiredItem As String` - Item needed to use hotspot
- `mIsActive As Boolean` - Whether hotspot can be interacted with

**Methods:**
```xojo
Sub Constructor(id As String, x As Integer, y As Integer, radius As Integer, type As eHotspotType)
  // Initialize hotspot with position and type

Function IsPointInside(mouseX As Integer, mouseY As Integer) As Boolean
  // Check if mouse coordinates are within interaction radius

Function GetX() As Integer
  // Public getter for X coordinate (fixes property access issue)

Function GetY() As Integer
  // Public getter for Y coordinate (fixes property access issue)

Function GetRadius() As Integer
  // Public getter for radius (fixes property access issue)

Sub SetDescription(desc As String)
  // Set examination text for hotspot

Sub SetRequiredItem(itemID As String)
  // Specify item needed to interact with this hotspot

Function GetInteractionText() As String
  // Return appropriate text for current interaction
```

### EscapeRoomItem (Class)
Collectible items in the player's inventory.

**Properties:**
- `mID As String` - Unique item identifier
- `mName As String` - Display name
- `mDescription As String` - Item description
- `mType As EscapeRoomConstants.eItemType` - Item category

**Methods:**
```xojo
Sub Constructor(id As String, name As String, description As String, type As eItemType)
  // Initialize item with basic properties

Function CanUseWith(targetID As String) As Boolean
  // Check if item can be used with specified target
```

### EscapeRoomConstants (Module)
Game constants, enumerations, and configuration values.

**Enums:**
```xojo
Enum eGameState
  MainMenu
  Playing
  Paused
  Completed
  Failed
  Instructions
End Enum

Enum eRoomState
  Locked
  InProgress
  Completed
  TimeOut
End Enum

Enum eRoomType
  Office
  Library
  Laboratory
  Basement
  Attic
End Enum

Enum eHotspotType
  Door
  Drawer
  Painting
  Safe
  Computer
  Book
  Switch
  Keypad
End Enum

Enum eItemType
  Key
  Tool
  Clue
  Component
  Usable
End Enum

Enum ePuzzleType
  CodeLock
  DragDrop
  Pattern
  Sequence
  Hidden
End Enum
```

**Constants:**
```xojo
Const kGameTitle = "Digital Escape Room"
Const kGameVersion = "v1.1"
Const kTimeLimit = 600  // 10 minutes in seconds
Const kMaxHints = 5
Const kMaxInventoryItems = 10
Const kBaseScore = 1000
Const kTimeBonusMultiplier = 10
Const kHintPenalty = 100
Const kHotspotRadius = 20
Const kInventorySlotSize = 50
Const kInventoryX = 20
Const kInventoryY = 650
Const kTimerX = 950
Const kTimerY = 20
Const kHintButtonX = 1200
Const kHintButtonY = 20
```

**Sound Resources:**
```xojo
Sound keyUnlock - key_unlock.mp3    // Key unlock interaction
Sound doorOpen - door_open.mp3      // Door opening transition
Sound smallWin - small_win.mp3      // Puzzle completion
Sound victory - victory.mp3         // Final victory
```

## Technical Implementation

### Scene Management
- Uses Shared Foundations Router for scene transitions
- Scenes inherit from GameScene base class
- Clean separation of menu, gameplay, and instruction scenes

### Rendering System
- Canvas-based rendering with 1280×720 fixed resolution
- Double-buffered via CanvasManager for smooth visuals
- Fallback rendering mode for framework issues
- Detailed realistic graphics for all 10 room types
- Enhanced themes: Executive Office, Medieval Library, Modern Laboratory, Industrial Basement, Victorian Attic

### Input Handling
- Router-based input distribution to current scene
- Special workarounds for scene input issues (instructions and game scenes)
- Full mouse and keyboard input support
- Mouse click detection for menu navigation and hotspot interaction
- Fixed menu mouse click bug through proper scene initialization

### Framework Integration
- Built on Shared Foundations architecture
- Extends base classes for game-specific functionality
- Uses AppTemplate for application lifecycle management
- Sound system integration with MP3 resource management

### Game Progression System
- 10-room escape sequence with increasing difficulty
- Progressive room themes: Office → Library → Laboratory → Basement → Attic → Enhanced rooms
- Key-based progression system requiring puzzle completion
- Sound feedback for key interactions and room transitions

### Error Handling
- Comprehensive try-catch blocks in all critical methods
- Fallback systems for framework failures
- Debug logging for troubleshooting

## Known Issues and Workarounds

### Router Input Forwarding Issues
**Problem:** Router doesn't properly forward input to some scenes
**Workaround:** Window1 directly handles input using scene-specific flags:
- `mInInstructionsScene` for EscapeRoomInstructionsScene
- `mInGameScene` for EscapeRoomGameScene
**Files Affected:** Window1.xojo_window, EscapeRoomMenuScene.xojo_code

### Menu Mouse Click Bug (RESOLVED v1.1.0)
**Problem:** Menu mouse clicks not working due to empty mMenuOptions array
**Root Cause:** Cleanup() method cleared array but Init() didn't repopulate it
**Solution:** Enhanced Init() method to properly reinitialize menu options array
**Files Affected:** EscapeRoomMenuScene.xojo_code

### Scene Constructor Compatibility
**Problem:** Scene constructors needed to match framework expectations
**Solution:** EscapeRoomInstructionsScene uses parameterless constructor calling `Super.Constructor("HowToPlay")`

### Hotspot Property Access
**Problem:** Protected properties in EscapeRoomHotspot couldn't be accessed externally
**Solution:** Added public getter methods (GetX(), GetY(), GetRadius())
**Files Affected:** EscapeRoomHotspot.xojo_code

## Build Configuration

**Target Platform:** Desktop (Windows, macOS, Linux)
**Window Size:** 1280×720 (fixed, windowed)
**API Version:** Xojo API 2.0
**Framework Dependency:** Shared Foundations (relative path: `../Shared Foundations/`)
**Sound Resources:** 4 MP3 files (key_unlock.mp3, door_open.mp3, small_win.mp3, victory.mp3)
**Asset Requirements:** No external dependencies beyond framework and sound files

## Code Standards

- **Naming Conventions:** kConstants, eEnums, mPrivateProperties
- **No Hardcoded Strings:** All text in constants or resource files
- **Error Handling:** Try-catch blocks in all public methods
- **Documentation:** Comprehensive inline comments
- **Framework Integration:** Proper inheritance and method overrides

## Contest Compliance

- **Resolution:** Fixed 1280×720 windowed interface
- **Professional Presentation:** Clean UI suitable for judging with enhanced graphics
- **Error-Free Operation:** Comprehensive error handling and fallbacks
- **Demo Capability:** Quick gameplay demonstration through 10 unique rooms
- **Full Feature Set:** Complete 10-room progression with sound effects
- **Mouse and Keyboard Support:** Both navigation methods fully functional
- **Documentation:** Complete README, DEVELOPER, and VERSION files

## Version 1.1.0 Enhancement Summary

### Major Features Added
- **10-Room Progression System:** Complete escape sequence through unique environments
- **Enhanced Graphics:** Realistic detailed drawings for all room types
- **Sound Integration:** 4 MP3 sound effects for key game interactions
- **Mouse Navigation Fix:** Resolved critical menu click bug
- **Advanced Room Themes:** 5 enhanced rooms (6-10) with specialized environments

### Technical Improvements
- Fixed empty mMenuOptions array initialization bug
- Added public getter methods for hotspot coordinates
- Enhanced room graphics with detailed furniture and environmental art
- Integrated sound system with MP3 resource management
- Improved input handling for both keyboard and mouse navigation

### Code Quality
- Removed all debug logging for production release
- Enhanced error handling and stability
- Updated comprehensive documentation
- Maintained contest compliance and professional presentation standards