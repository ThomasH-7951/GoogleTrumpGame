extends Node2D

# systeme de degat / pv
const max_hp = 200
var hp = 200:
	set(value):          # ← appelé dautomatiquement quand hp change
		hp = value
		$"/root/Node2D/CanvasLayer/ProgressBar".value = hp
		if hp <= 0:
			print("game over !")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/ProgressBar.max_value = max_hp
	$CanvasLayer/ProgressBar.value = hp
