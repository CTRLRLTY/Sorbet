extends Control

signal passed
signal failed


onready var multi_choice: Control = $MultiChoice
onready var fixed_character: Control = $FixedCharacter


func _ready() -> void:
	for child in get_children():
		child.connect("passed", self, "emit_signal", ["passed"])
		child.connect("failed", self, "emit_signal", ["failed"])


func use_mode(mode: int) -> void:
	var m := get_child(mode)
	
	for child in get_children():
		child.visible = child == m


func pause() -> void:
	for child in get_children():
		if child.has_method("pause"):
			child.pause()


func reset() -> void:
	for child in get_children():
		if child.has_method("reset"):
			child.reset()
