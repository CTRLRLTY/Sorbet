extends Control


var object_name: String


func _ready() -> void:
	randomize()
	randomize_object_name()
	
	print_debug(object_name)


func randomize_object_name() -> void:
	var NAME_LIST := [
		"cow",
		"dog",
		"horse",
		"chicken",
		"duck",
		"sheep",
		"cat",
		"rabbit",
	]
	
	var idx := randi() % (NAME_LIST.size() - 1)
	
	object_name = NAME_LIST[idx]
