extends Control


func _on_Back_pressed() -> void:
	SceneManager.goto_title_screen()


func _on_Farm_pressed() -> void:
	SceneManager.goto_level_object_naming()
