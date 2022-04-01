extends Control

signal back_to_menu_request


onready var point_gain: Control = $VBox/PointGain
onready var spanner: Control = $VBox/Spanner


func _ready() -> void:
	connect("visibility_changed", self, "_on_visibility_changed")


func _on_visibility_changed() -> void:
	if not visible:
		return
	
	var points := RuntimeManager.point_accumulated
	
	point_gain.point = points
	
	if points >= 0:
		spanner.show_gain()
	else:
		spanner.show_loss()


func _on_Back_pressed() -> void:
	emit_signal("back_to_menu_request")
