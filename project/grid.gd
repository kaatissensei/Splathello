extends GridContainer
#var SquareGrid = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SquareGrid.resize(36)
	_reset_grid()
		
func _populate_grid() -> void:
	var squareNum = 1
	
	for c in range(8):
		for r in range(8):
			var AddButton = Button.new()
			add_child(AddButton)
			AddButton.set_name("Square[%s,%s]" % [c,r])
			AddButton.set_text("%s" % [squareNum])
			#Adjust Size
			AddButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			AddButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
			#Adjust color
			#AddButton.self_modulate = Color(1,1,1,0.2)
			#Add signal
			AddButton.connect("pressed", check_square.bind(AddButton))
			#Adjust styles
			var style = StyleBoxFlat.new()
			style.bg_color = Color(0,0,0,0)
			style.border_color = Color(.1,.1,.1)
			style.set_border_width_all(1)
			AddButton.add_theme_stylebox_override("normal", style)
			AddButton.add_theme_stylebox_override("hover", style)
			var emptyStyle = StyleBoxEmpty.new()
			AddButton.add_theme_stylebox_override("focus", emptyStyle)
			
			squareNum += 1
	
func _reset_grid() -> void:
	for n in get_children():
		n.free()
	_populate_grid()
	_fill_starting_squares()
	
func _fill_starting_squares():
	var numPlayers = Splathello.numPlayers
	var p1Color = "blue"
	var p2Color = "orange"
	var p3Color = "green"
	var p4Color = "pink"
	
	if numPlayers == 2:
		_capture_square(3,3, p1Color)
		_capture_square(4,4, p1Color)
		_capture_square(3,4, p2Color)
		_capture_square(4,3, p2Color)		
	else: #if 4
		_capture_square(3,3, p1Color)
		_capture_square(2,4, p1Color)
		_capture_square(3,4, p2Color)
		_capture_square(4,5, p2Color)
		_capture_square(3,2, p3Color)
		_capture_square(4,3, p3Color)
		_capture_square(4,4, p4Color)
		_capture_square(5,3, p4Color)

func check_square(btn) -> void:
	var currentColor = get_currentColor()
	if currentColor != null:
		#Get row, col coordinates of clicked square
		var btnName = btn.name
		var r = btnName.substr(7,1).to_int()
		var c = btnName.substr(9,1).to_int()
		
		if Splathello.squareColors[r][c] == "":   #if that square has no color yet
			_capture_square(r, c, currentColor)
			for x in range(-1, 2):  #exclusive?
				for y in range(-1,2):
					if x == 0 and y == 0:
						print("%s,%s" % [r,c])
					else:
						_look_for_squares(r, c, x, y)
			
	
func _capture_square(r, c, color = "blue") -> void: #used to color in square
	var btn = %Grid.get_node("Square[%s,%s]" % [r, c])
	Splathello.squareColors[r][c] = color
	var style = StyleBoxFlat.new()
			#var blankStyle = StyleBoxEmpty.new()
	style.bg_color = Splathello.get_rgb(color)
	btn.add_theme_stylebox_override("normal", style)
	btn.add_theme_stylebox_override("hover", style)
	btn.add_theme_stylebox_override("pressed", style)
	
func _look_for_squares(r, c, rOff, cOff, d = 1) -> void:
	var gridSize = 8
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
	


func _on_button_pressed() -> void:
	_fill_starting_squares()
