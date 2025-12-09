extends Control


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
