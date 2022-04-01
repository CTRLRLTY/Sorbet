extends Panel

var point := 0 setget set_point

onready var label: Label = $Label


func set_point(amount: int) -> void:
	point = amount
	
	label.text = str(point)
