extends Node

var currentColor #string "blue", "orange", etc.
var currentSquareNum
var numPlayers		#2 or 4
var currentStage #name of current stage
var winningColor
var triggerReset #bool used when exiting menu

var gridNumOn
var headersOn
var playerColors   #0 was BO, 1 was GP, 2 was IY
var squareColors = [] #[8,8] https://gamedevacademy.org/gdscript-2d-array-tutorial-complete-guide/
var changedSquares = []
var coloredSquareCount #How many squares are left
var gridSize #Number of rows/columns
var newGame #bool to trigger board reset
var startingPieces #bool for inital placement of tiles (Othello)
var scores = [4] #4 players' scores

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numPlayers = 4
	playerColors = 0
	gridNumOn = true
	headersOn = false
	gridSize = 8
	startingPieces = true
	_set_random_stage()
	#_reset_main_grid()
	coloredSquareCount = 0
	reset_squareColors()
	
func set_currentColor(newCurrentColor):
	currentColor = newCurrentColor

func set_numPlayers(newNum):
	numPlayers = newNum
	
func set_currentStage(stageName):
	currentStage = stageName
	
func reset_squareColors():
	squareColors = []
	for i in range(gridSize):
		squareColors.append([])
		for j in range(gridSize):
			squareColors[i].append("")

func get_rgb(color) -> Color:
	match color:
		"blue":
			return Color8(70,100,240,255)
		"orange":
			return Color8(255, 100, 20,255)#Color8(250,120,50)
		"green":
			return Color8(0,230,0,255)
		"pink":
			return Color8(255,100,180,255)
		"indigo":
			return Color8(90, 64, 255,255)
		"yellow":
			return Color8(255, 235, 40,255)
		_:
			return Color8(0,0,0,0)
		
func _set_random_stage():
	#Hardcode for now, later pull and clean from folder
	var stages = ["stgArowanaMall", "stgBrinewaterSprings", "stgCampTriggerfish", "stgMahiMahiResort", "stgMantaMarina", "stgUmamiRuins"]
	var random_index = randi() % stages.size()
	currentStage = stages[random_index]
