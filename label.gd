extends Label

# Define the colors
var normal_color = Color(1, 1, 1) # White
var hover_color = Color8(255, 255, 180)  # Yellowish

func _ready():
	# Set the initial color
	#var label = get_child()
	self.add_theme_color_override("font_color", normal_color)

# Signal handler for mouse_entered
func _on_label_mouse_entered():
	self.add_theme_color_override("font_color", hover_color)

# Signal handler for mouse_exited
func _on_label_mouse_exited():
	self.add_theme_color_override("font_color", normal_color)

func _select_stage():#stageName = ""):
	for border in get_tree().get_nodes_in_group("SelectedStages"):
		border.visible = false
	#if stageName == "":
	self.get_parent().get_node("Selected").visible = true
		
	#Set stage in main scene
	var stageName = self.get_parent().name
	Splathello.set_currentStage(stageName)
