extends Control


onready var multi_choice: Control = $MultiChoice
onready var fixed_character: Control = $FixedCharacter


func use_mode(mode: int) -> void:
	var m := get_child(mode)
	
	for child in get_children():
		child.visible = child == m


func pause() -> void:
	for child in get_children():
		if child.has_method("pause"):
			child.pause()
