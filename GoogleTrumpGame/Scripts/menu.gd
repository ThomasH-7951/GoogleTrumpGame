extends Control
@onready var firstlevel = preload("res://Scenes/Level.tscn") 

func _on_start_btn_button_down() -> void:
	get_tree().change_scene_to_packed(firstlevel)


func _on_quit_btn_button_down() -> void:
	get_tree().quit()
