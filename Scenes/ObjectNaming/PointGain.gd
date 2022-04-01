extends Panel

var point := 0 setget set_point

onready var label: Label = $Label


func _ready() -> void:
	connect("visibility_changed", self, "_on_visibility_changed")


func set_point(amount: int) -> void:
	point = amount
	
	label.text = str(point)


func _on_visibility_changed() -> void:
	set_point(RuntimeManager.point_accumulated)
