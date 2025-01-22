extends Control

func _ready() -> void:
	#var currentStage = Splathello.currentStage
	set_stage_border()
	set_num_players(Splathello.numPlayers)
	set_buttons_pressed()
	
	
func set_stage_border():
	for border in get_tree().get_nodes_in_group("SelectedStages"):
		border.visible = false
	%Stages.get_node("GridContainer/%s/Selected" % Splathello.currentStage).visible = true
	
func set_num_players(num):
	Splathello.set_numPlayers(num)
	var playerColors = _get_playerColor_text(Splathello.playerColors)
	
	change_player_color(playerColors)
	
func change_player_color(colors):
	var textureName = "squid %s" % colors
	
	match colors:
		"greenPink":
			Splathello.playerColors = 1
			#textureName = "squid greenPink"
		"indigoYellow":
			Splathello.playerColors = 2
			textureName = "octopus indigoYellow"
		_:
			Splathello.playerColors = 0
			#textureName = "squid blueOrange"
	
	_update_menu_squid_texture(textureName)
	
func _update_menu_squid_texture(textureName):
	if Splathello.numPlayers == 2:
		textureName = textureName + "_selected"

		var texture4P = load("res://images/ui/squid 4p.png")
		%Squid4P.texture_normal = texture4P
	else:
		var texture4P = load("res://images/ui/squid 4p_selected.png")
		%Squid4P.texture_normal = texture4P
	
	var texture2P = load('res://images/ui/%s.png' % [textureName])
	%Squid2P.texture_normal = texture2P
	
func _get_playerColor_text(playerColorInt):
	var colorText
	match playerColorInt:
		1:
			colorText = "greenPink"
		2:
			colorText =  "indigoYellow"
		_:
			colorText =  "blueOrange"
	return colorText
	
func set_buttons_pressed():
	if Splathello.headersOn:
		%HeadersOn.button_pressed = true
	else:
		%GridNumsOn.button_pressed = true
		
	if Splathello.startingPieces:
		%SPOn.button_pressed = true
	else:
		%SPOff.button_pressed = true
	
func _toggle_startingPieces(tf):
	if tf:
		Splathello.startingPieces = true
		%SPOn.button_pressed = true
	else:
		Splathello.startingPieces = false
		%SPOff.button_pressed = true

func _set_visible_labels(labelType):
	if labelType == "Headers":
		Splathello.headersOn = true
		Splathello.gridNumOn = false
	else: #Grid Numbers
		Splathello.headersOn = false
		Splathello.gridNumOn = true
		
#func set_currentStage(stageName):
	#Splathello.currentStage = stageName
	#var stageTexture = load('res://images/backgrounds/%s.png' % [stageName])
	
func _close_menu(resetTrigger):
	Splathello.triggerReset = resetTrigger;
	get_tree().change_scene_to_file("res://splathelloScene.tscn")
