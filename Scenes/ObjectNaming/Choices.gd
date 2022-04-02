extends GridContainer

signal choice_pressed(text)


func _ready() -> void:
	for btn in get_children():
		if btn is Button:
			btn.connect("pressed", self, "_on_choice_pressed", [btn])


func _on_choice_pressed(button: Button) -> void:
	button.disabled = true
	
	emit_signal("choice_pressed", button.text)
