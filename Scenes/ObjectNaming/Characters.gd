extends VBoxContainer

signal character_selected(character)


var button_group := ButtonGroup.new()


func _ready() -> void:
	for button in get_child(0).get_children():
		button.group = button_group

		button.connect("pressed", self, "_on_character_pressed", [button])


func _on_character_pressed(button: Button) -> void:
	button.disabled = true
	
	emit_signal("character_selected", button.text)
