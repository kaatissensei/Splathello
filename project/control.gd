extends Control

#TODO: Change undo array to 3d array
	#Don't de-select Squids when tapped second time < not worth the time
#Maybe eventually: drag and drop initiative

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_stage_texture() # Replace with function body.
	_show_hide_headers()
	if (Splathello.numPlayers == 4):
		%TokenButton.visible = true
	else:
		%TokenButton.visible = false

func _open_menu() -> void:
	get_tree().change_scene_to_file("res://splathelloMenu.tscn")

func _open_results():
	var resultsScene = load("res://Results.tscn").instantiate()
	get_tree().get_root().add_child(resultsScene)
	#get_tree().change_scene_to_file("res://Results.tscn")
	
func _set_stage_texture():
	var stageName = Splathello.currentStage
	var stageTexture = load('res://images/backgrounds/%s.png' % [stageName])
	%StageBG.texture = stageTexture

func _show_hide_headers() -> void:
	var tf
	if Splathello.headersOn:
		tf = true
		%HeaderSpacer.custom_minimum_size = Vector2(20,0)
	else:
		tf = false
		%HeaderSpacer.custom_minimum_size = Vector2(0,0)
		
	%ColHeaders.visible = tf
	%RowHeaders.visible = tf
	if tf:
		adapt_header_to_grid_size()
	
func adapt_header_to_grid_size():
	for header in get_tree().get_nodes_in_group("Headers"):
		visible = true
		
	if Splathello.gridSize < 8:  #7
		$ColHeaders/H.visible = false
		$"RowHeaders/8".visible = false
	if Splathello.gridSize < 7:  #6
		$ColHeaders/G.visible = false
		$"RowHeaders/7".visible = false
	if Splathello.gridSize < 6:  #5
		$ColHeaders/F.visible = false
		$"RowHeaders/6".visible = false
		

func _reset_confirmation():
	%ResetConfirmation.visible = true;
	
func _reset_confirmation_click():
	%ResetConfirmation.visible = false
