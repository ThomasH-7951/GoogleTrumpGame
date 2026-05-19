extends CanvasLayer

func dead():
	get_tree().paused = true
	show()



func _on_restart_btn_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
