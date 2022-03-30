extends Control

signal guest_login


onready var main: Control = $MainPanel
onready var login: Control = $LoginPanel
onready var signup: Control = $SignupPanel



func show_panel(panel: Control) -> void:
	assert(is_a_parent_of(panel))
	
	for child in get_children():
		child.hide()
	
	panel.show()


func _on_GooglePlay_pressed() -> void:
	pass 


func _on_Email_pressed() -> void:
	pass # Replace with function body.


func _on_CreateAccount_pressed() -> void:
	pass # Replace with function body.


func _on_Guest_pressed() -> void:
	emit_signal("guest_login")
