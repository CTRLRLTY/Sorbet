extends HBoxContainer


signal quit_request
signal hint_request



func _on_Quit_pressed() -> void:
	emit_signal("quit_request")


func _on_Hint_pressed() -> void:
	emit_signal("hint_request")
