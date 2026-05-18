extends Control
@onready var firstlevel = preload("res://Scenes/niveautest.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_btn_button_down() -> void:
	get_tree().change_scene_to_packed(firstlevel)


func _on_quit_btn_button_down() -> void:
	get_tree().quit()
