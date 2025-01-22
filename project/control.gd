extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_stage_texture() # Replace with function body.
	_show_hide_headers()

func _open_menu() -> void:
	get_tree().change_scene_to_file("res://splathelloMenu.tscn")

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
	
