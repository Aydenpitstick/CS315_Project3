extends Node

var levers = 0

func _process(delta: float) -> void:
	if levers >= 3:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		levers = 0

func leverPull():
	levers = levers + 1
	
