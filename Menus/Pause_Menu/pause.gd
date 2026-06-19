extends CanvasLayer

func pause_unpaused():
	if get_tree().paused:
		get_tree().paused = false
		print("depaused")
		hide()
	else:
		get_tree().paused = true
		print("paused")
		show()

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("Pause"):
		pause_unpaused()
