extends Node2D
const max_hp = 200
var hp = 200:
	set(value):
		hp = value
		$CanvasLayer/ProgressBar.value = hp
		if hp <= 0:
			print("boss mort !")

func _ready() -> void:
	add_to_group("boss")
	$CanvasLayer/ProgressBar.max_value = max_hp
	$CanvasLayer/ProgressBar.value = hp
