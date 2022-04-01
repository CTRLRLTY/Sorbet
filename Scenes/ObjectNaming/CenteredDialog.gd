extends Panel

signal quit

onready var center: CenterContainer = $Center
onready var over_dialog: Control = $Center/OverDialog
onready var quit_dialog: Control = $Center/QuitDialog


func _ready() -> void:
	for dialog in center.get_children():
		dialog.hide()
	
	hide()


func popup_dialog(dialog: Control) -> void:
	assert(is_a_parent_of(dialog))
	
	for child in center.get_children():
		child.visible = child == dialog
	
	show()


func popup_quit_dialog() -> void:
	popup_dialog(quit_dialog)


func popup_over_dialog() -> void:
	popup_dialog(over_dialog)


func _on_QuitDialog_quit() -> void:
	emit_signal("quit")


func _on_QuitDialog_cancel() -> void:
	hide()
