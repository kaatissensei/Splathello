extends GridContainer
var gridSize
#var SquareGrid = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gridSize = Splathello.gridSize #Should be even, honestly should just be 8
	%Grid.columns = gridSize
	#SquareGrid.resize(36)
	_reset_grid()
		
func _populate_grid() -> void:
	var squareNum = 1
		
	for c in range(gridSize):
		for r in range(gridSize):
			var AddButton = Button.new()
			add_child(AddButton)
			AddButton.set_name("Square[%s,%s]" % [c,r])
			AddButton.set_text("%s" % [squareNum])
			AddButton.add_to_group("GridButtons")
			
			#Adjust Size
			AddButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			AddButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
			
			#Add signal
			AddButton.connect("pressed", check_square.bind(AddButton))
			#Adjust styles
			var menuTheme = load("res://SplatoonScene.tres") as Theme
			AddButton.theme = menuTheme
			##var style = menuTheme.get_stylebox("Button", "Button")

			var style = StyleBoxFlat.new()
			var btnColor = Splathello.squareColors[c][r]
			style.bg_color = Splathello.get_rgb(btnColor)#Color(0,0,0,0)
			style.border_color = Color(.1,.1,.1)
			
			style.set_border_width_all(1)
			AddButton.add_theme_color_override("font_color", Color8(1,1,1))
			AddButton.add_theme_font_size_override("font_size", 50)
			if Splathello.gridNumOn and btnColor == "":
				_show_grid_text(AddButton)
			else:
				_hide_grid_text(AddButton)
				#style.set_border_width_all(0)
			
			AddButton.add_theme_stylebox_override("normal", style)
			AddButton.add_theme_stylebox_override("hover", style)
			#var emptyStyle = StyleBoxEmpty.new()
			
			#AddButton.add_theme_stylebox_override("focus", emptyStyle)
			
			squareNum += 1
	
func _show_grid_text(btn):
	btn.add_theme_constant_override("outline_size", 3)
	btn.add_theme_color_override("font_hover_color", Color(.9,.9,.9,1))
	btn.add_theme_color_override("font_outline_color", Color(0,0,0))
	btn.add_theme_color_override("font_color", Color(.9,.9,.9))
	
func _hide_grid_text(btn):
	btn.add_theme_color_override("font_color", Color8(0,0,0,0))
	btn.add_theme_color_override("font_hover_color", Color8(0,0,0,0))
	btn.add_theme_color_override("font_focus_color", Color8(0,0,0,0))
	btn.add_theme_constant_override("outline_size", 0)

func _reset_grid() -> void:
	if Splathello.triggerReset:
		Splathello.reset_squareColors()
	for n in get_children():
		n.free()
	_populate_grid()
	if Splathello.triggerReset and Splathello.startingPieces:
		_fill_starting_squares()
		Splathello.changedSquares = []
	Splathello.triggerReset = false
	
func _fill_starting_squares():
	var numPlayers = Splathello.numPlayers
	var p1Color = "blue"
	var p2Color = "orange"
	
	match Splathello.playerColors:
		1:
			p1Color = "green"
			p2Color = "pink"
		2:
			p1Color = "indigo"
			p2Color = "yellow"
		_:
			p1Color = "blue"
			p2Color = "orange"
	
	var p3Color = "green"
	var p4Color = "pink"
	
	var r = (gridSize / 2)
	#Remember coordinates are 0 inclusive, so all are -1
	if numPlayers == 2:
		_capture_square(r-1,r-1, p1Color)
		_capture_square(r,r, p1Color)
		_capture_square(r-1,r, p2Color)
		_capture_square(r,r-1, p2Color)		
	else: #if 4
		_capture_square(r-1,r-1, p1Color)
		_capture_square(r-2,r, p1Color)
		_capture_square(r-1,r, p2Color)
		_capture_square(r,r+1, p2Color)
		_capture_square(r-1,r-2, p3Color)
		_capture_square(r,r-1, p3Color)
		_capture_square(r,r, p4Color)
		_capture_square(r+1,r-1, p4Color)

func check_square(btn) -> void:
	var currentColor = get_currentColor()
	
	#Reset changedSquares
	Splathello.changedSquares = []
	
	#WIP ADD IF FOR ERASE -or is undo enough?
	if currentColor != null: #if a color has not yet been chosen
		#Get row, col coordinates of clicked square
		var btnName = btn.name
		var r = btnName.substr(7,1).to_int()
		var c = btnName.substr(9,1).to_int()
		
		
		if Splathello.squareColors[r][c] == "":   #if that square has no color yet
			_capture_square(r, c, currentColor)
			for x in range(-1, 2):  #exclusive?
				for y in range(-1,2):
					if x == 0 and y == 0:
						pass#print("%s,%s" % [r,c])
					else:
						_look_for_squares(r, c, x, y)
		#else:
			#pass
	
		
	
func _capture_square(r, c, color = "blue", undo = false) -> void: #used to color in square
	var btn = %Grid.get_node("Square[%s,%s]" % [r, c])
	if undo == false:
		Splathello.changedSquares.push_back([r,c,Splathello.squareColors[r][c]])
	Splathello.squareColors[r][c] = color
	
	var style = StyleBoxFlat.new()
	var menuTheme = load("res://SplatoonScene.tres") as Theme
	var resetStyle = menuTheme.get_stylebox("Button", "Button")
	#var blankStyle = StyleBoxEmpty.new()
	if color == "":
		resetStyle.border_color = Color(.1,.1,.1)
		btn.add_theme_stylebox_override("normal", resetStyle)
		btn.add_theme_stylebox_override("hover", resetStyle)
		btn.add_theme_stylebox_override("pressed", resetStyle)
		btn.add_theme_stylebox_override("hover_pressed", resetStyle)
		_show_grid_text(btn)
	else:
		style.bg_color = Splathello.get_rgb(color)
		btn.add_theme_stylebox_override("normal", style)
		btn.add_theme_stylebox_override("hover", style)
		btn.add_theme_stylebox_override("pressed", style)
		btn.add_theme_stylebox_override("hover_pressed", style)
		#Hide text when captured
		_hide_grid_text(btn)
	
#func load_current_game():
	#var style = StyleBoxFlat.new()
	#for btn in get_tree().get_nodes_in_group("GridButtons"):
		#style.bg_color = Splathello.get_rgb()
		#btn.add_theme_stylebox_override("normal", style)
		#btn.add_theme_stylebox_override("hover", style)
		#btn.add_theme_stylebox_override("pressed", style)
		#btn.add_theme_stylebox_override("hover_pressed", style)
	
func _look_for_squares(r, c, rOff, cOff, d = 1) -> void:
	var currentColor = get_currentColor()
	# And squareX + ((d + 1) * x) >= 0 And squareY + ((d + 1) * y) >= 0) Then
	if (r + (d+1)*rOff) < gridSize and c + (d+1)*cOff < gridSize and r + (d+1)*rOff >= 0 and c + (d+1)*cOff >= 0:
		var checkedSquareColor = Splathello.squareColors[r + (d) * rOff][c + (d) * cOff]
		var farSquareColor = Splathello.squareColors[r + (d + 1) * rOff][ c + (d + 1) * cOff]
		if checkedSquareColor != "" and checkedSquareColor != currentColor:
			if farSquareColor == "":
				return
			elif farSquareColor == currentColor:
				for dist in range(1, d+1): #exclusive, so +1
					_capture_square(r + (dist) * rOff, c + (dist) * cOff, currentColor)
			else:
				_look_for_squares(r, c, rOff, cOff, d + 1)
	pass

func get_currentColor():
	return Splathello.currentColor
	
func _undo():
	for square in Splathello.changedSquares:
		_capture_square(square[0],square[1], square[2], true)
	
#func _show_hide_headers():
	#var tf = Splathello.headersOn
	#for header in get_tree().get_nodes_in_group("Headers"):
		#header.visible = tf
		
