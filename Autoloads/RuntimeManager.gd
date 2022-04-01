extends Node


var login := false
var point_accumulated := 0


func _ready() -> void:
	OS.low_processor_usage_mode = true
