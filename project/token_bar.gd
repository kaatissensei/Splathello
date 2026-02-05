extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _move_token(tokenName):
	var AddButton = TextureButton.new()
	%InitiativeBar.add_child(AddButton)
	AddButton.set_name(tokenName)
	AddButton.add_to_group("Initiative")
	
	var texture = load("res://images/inklings/tokens/%s.png" % tokenName)
	AddButton.texture_normal = texture
	AddButton.ignore_texture_size = true
	#var tokenStyle = StyleBoxTexture.new()
	#tokenStyle.texture = texture
	#AddButton.add_theme_stylebox_override("normal", tokenStyle)
	#Adjust Size
	AddButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	AddButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
	AddButton.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	#AddButton.size_flags_stretch_ratio
	
	#Add signal
	AddButton.connect("pressed", delete_from_initiative.bind(AddButton))
	
	if Splathello.initiative.size() == 0:
		var color = tokenName.left(tokenName.length() - 1)
		press_inkling_btn(color)
	Splathello.initiative.push_back(AddButton)

func delete_from_initiative(btn):
	btn.queue_free()  #removes object from scene
	Splathello.initiative.erase(btn)
	match btn.name:
		"Blue1":
			%Blue1Btn.button_pressed = false
		"Blue2":
			%Blue2Btn.button_pressed = false
		"Orange1":
			%Orange1Btn.button_pressed = false
		"Orange2":
			%Orange2Btn.button_pressed = false
		"Green1":
			%Green1Btn.button_pressed = false
		"Green2":
			%Green2Btn.button_pressed = false
		"Pink1":
			%Pink1Btn.button_pressed = false
		"Pink2":
			%Pink2Btn.button_pressed = false
			
	#Autoselect next color
	if Splathello.initiative.size():
		var nextTokenName = Splathello.initiative[0].name
		var nextColor = nextTokenName.left(nextTokenName.length() - 1)
		if Splathello.autoSelectColor:
			press_inkling_btn(nextColor)

func press_inkling_btn(color):
	var squidBtnName = "%inkling" + color
	var squidBtn = get_node(squidBtnName)
	squidBtn.emit_signal("pressed")
	squidBtn.button_pressed = true
	
func _initiative_popup():
	if %InitiativePopup.visible == false:
		%InitiativePopup.visible = true
	else:
		%InitiativePopup.visible = false
		
	if %InitiativeBar.get_child_count() == 1:
		_reset_tokens()
		
func _reset_tokens():
	for token in get_tree().get_nodes_in_group("PressedTokens"):
		token.button_pressed = false
	for initToken in get_tree().get_nodes_in_group("Initiative"):
		initToken.visible = false
	Splathello.initiative = []
	
