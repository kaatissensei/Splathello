extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _start() -> void:
	Splathello.triggerReset = true
	get_tree().change_scene_to_file("res://splathelloScene.tscn")
	
func _fullscreen():
	Splathello.fullscreen()


func _open_menu() -> void:
	get_tree().change_scene_to_file("res://splathelloMenu.tscn")
