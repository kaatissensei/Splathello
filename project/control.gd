extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_currentColor(playerColor) -> void:
	Splathello.set_currentColor(playerColor)
	print(">" + playerColor)
