extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	var rand = (randf()/5)+0.9
	var rand2 = randi()%5
	global_rotation=randi()%360
	$AudioStreamPlayer.volume_db=rand2
	$AudioStreamPlayer.pitch_scale=rand
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.animation="default"
	$AnimatedSprite2D.play()
	await get_tree().create_timer(0.4).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
