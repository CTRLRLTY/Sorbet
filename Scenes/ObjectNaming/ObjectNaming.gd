extends Control


var object_name: String

onready var object_label := find_node("ObjectLabel")


func _ready() -> void:
	randomize()
	randomize_object_name()
	
	print_debug(object_name)



func randomize_object_name() -> void:
	var NAME_LIST := [
		"cow",
		"chicken",
		"sheep",
		"pig"
	]
	
	var idx := randi() % (NAME_LIST.size() - 1)
	
	object_name = NAME_LIST[idx]
	
	object_label.text = object_name
