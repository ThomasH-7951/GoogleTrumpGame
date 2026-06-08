extends Control
@onready var firstlevel = preload("res://Jeu/Level.tscn") 
func _ready() -> void:
	get_tree().paused = false
func _on_start_btn_button_down() -> void:
	get_tree().change_scene_to_packed(firstlevel)

func _input(event):
	if event.is_action_pressed("Espace"):
		_on_start_btn_button_down()
		
func _on_quit_btn_button_down() -> void:
	get_tree().quit()
#func _process(delta: float) -> void:
	#var randop = randf()
	#print(randop)
	#$TextureRect.modulate = Color(randop,randop,randop)
