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
	AddButton.connect("pressed", delete.bind(AddButton))
	pass

func delete(btn):
	btn.queue_free()

func _initiative_popup():
	if %InitiativePopup.visible == false:
		%InitiativePopup.visible = true
	else:
		%InitiativePopup.visible = false
