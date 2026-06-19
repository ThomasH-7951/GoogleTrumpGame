extends CanvasLayer


func dead():
	get_tree().paused = true
	show()
	
func _input(event):
	if event.is_action_pressed("Espace"):
		_on_restart_btn_button_down()

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	$"../DeathScreen".process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_restart_btn_button_down() -> void:
	print("death_screen_quitter")
	
	get_tree().change_scene_to_file("res://Menus/Start_Menu/Menu.tscn")
	

func _on_visibility_changed():
	print(visible)
	$DS_audio.play()
