extends Node

var currentColor #string "blue", "orange", etc.
var currentSquareNum
var numPlayers
var currentStage
var winningColor

var gridNumOn
var headersOn
var playerColors   #0 was BO, 1 was GP, 2 was IY
var squareColors = [] #[8,8] https://gamedevacademy.org/gdscript-2d-array-tutorial-complete-guide/
var coloredSquareCount #How many squares are left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numPlayers = 4
	gridNumOn = true
	headersOn = true
	#_reset_main_grid()
	coloredSquareCount = 0
	for i in range(8):
		squareColors.append([])
		for j in range(8):
			squareColors[i].append("")
	
func set_currentColor(newCurrentColor):
	currentColor = newCurrentColor
	
func get_rgb(color) -> Color:
	match color:
		"blue":
			return Color8(70,100,240)
		"orange":
			return Color8(255, 100, 20)#Color8(250,120,50)
		"green":
			return Color8(0,230,0)
		"pink":
			return Color8(255,100,180)
		_:
			return Color8(0,0,0)
		
