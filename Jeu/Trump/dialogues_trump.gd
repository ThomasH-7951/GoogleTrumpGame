extends Control

var trump: Node2D = null
var dialogue_index = 0
var dialogue_subindex = 0

var dialogue = [
	[
		"dialogue_0_0",
		"dialogue_0_1",
		"dialogue_0_2"
	],
	[
		"We will make america great again"
	],
	["Les réfrégirateurs sont moins chers chez but!",
	"Si juvabien, c'est Juvamine!",
	"Entrez dans Xar saroth"
	]
]


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	dialogue_index = trump.dialogue_index
	print("index : ",dialogue_index)
	print(dialogue)
	get_tree().paused = true
	print(dialogue[0])
	print(dialogue[0][0])
	
	
	
var char_delay := 0.05
var char_timer := 0.0

func _process(delta: float) -> void:
	if dialogue_subindex == 0:
		dialogue_index = trump.dialogue_index
		$RichTextLabel.text = dialogue[dialogue_index][dialogue_subindex]
		$RichTextLabel.visible_characters = 0
		dialogue_subindex += 1

	if Input.is_action_just_pressed("Shooting"):
		print("loading...")
		load_dialogue()

	if $RichTextLabel.visible_characters < $RichTextLabel.get_total_character_count():
		char_timer += delta
		while char_timer >= char_delay:
			char_timer -= char_delay
			$RichTextLabel.visible_characters += 1
			
			var index = $RichTextLabel.visible_characters - 1
			var texte = $RichTextLabel.text
			
			if index >= 0 and index < texte.length():
				var caractere = texte[index]
				if caractere != " ":
					$AudioStreamPlayer.play()
			
			if $RichTextLabel.visible_characters >= $RichTextLabel.get_total_character_count():
				break

func load_dialogue() -> void:
	print(dialogue[dialogue_index].size())
	if dialogue_subindex < dialogue[dialogue_index].size():
		$RichTextLabel.text = dialogue[dialogue_index][dialogue_subindex]
		print("trump : ",dialogue[dialogue_index][dialogue_subindex])
		$RichTextLabel.visible_characters=0
		dialogue_subindex += 1
	else:
		get_tree().paused = false
		queue_free()
