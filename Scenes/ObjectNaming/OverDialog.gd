extends Control

signal back_to_menu_request


onready var point_gain: Control = $VBox/PointGain
onready var spanner: Control = $VBox/Spanner


func _on_Back_pressed() -> void:
	emit_signal("back_to_menu_request")
