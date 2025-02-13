extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_visibility()

func set_currentColor(playerColor) -> void:
	Splathello.set_currentColor(playerColor)

func _set_visibility():
	var numPlayers = Splathello.numPlayers
	if numPlayers == 4:
		for inkling in get_tree().get_nodes_in_group("Inklings"):
			inkling.visible = true
		%octolingYellow.visible = false
		%octolingIndigo.visible = false
	else:
		for inkling in get_tree().get_nodes_in_group("Inklings"):
			inkling.visible = false
		match Splathello.playerColors:
			0:
				%inklingBlue.visible = true
				%inklingOrange.visible = true
			1:
				%inklingGreen.visible = true
				%inklingPink.visible = true
			2:
				%octolingIndigo.visible = true
				%octolingYellow.visible = true
