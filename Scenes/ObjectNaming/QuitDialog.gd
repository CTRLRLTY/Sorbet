extends VBoxContainer


signal quit
signal cancel



func _on_Yes_pressed() -> void:
	emit_signal("quit")


func _on_No_pressed() -> void:
	emit_signal("cancel")
