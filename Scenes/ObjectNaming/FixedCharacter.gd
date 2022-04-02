extends Control

signal character_selected(c)

onready var filled: Label = $Filled
onready var characters: Control = $Characters


func _ready() -> void:
	characters.connect("character_selected", self, "_on_character_selected")


func set_characters(chars: PoolStringArray) -> void:
	var buttons: Array = characters.button_group.get_buttons()
	
	assert(chars.size() == buttons.size())
	
	for i in range(buttons.size()):
		buttons[i].text = chars[i]


func char_count() -> int:
	var buttons: Array = characters.button_group.get_buttons()
	
	return buttons.size()


func _on_character_selected(c: String) -> void:
	emit_signal("character_selected", c)
