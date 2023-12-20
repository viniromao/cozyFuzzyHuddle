extends Node3D

var main_scene_load = load("res://scenes/main_scene.tscn")
#var tutorial_scene_load = load("res://scenes/tutorial_scene.tscn")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E:
			get_tree().change_scene_to_packed(main_scene_load)

