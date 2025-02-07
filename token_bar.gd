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
	pass

func delete_from_initiative(btn):
	btn.queue_free()
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

func _initiative_popup():
	if %InitiativePopup.visible == false:
		%InitiativePopup.visible = true
	else:
		%InitiativePopup.visible = false
		
func _reset_tokens():
	for token in get_tree().get_nodes_in_group("PressedTokens"):
		token.button_pressed = false
	for initToken in get_tree().get_nodes_in_group("Initiative"):
		initToken.visible = false
