extends Control


func _on_ObjectNaming_pressed() -> void:
	SceneManager.goto_level_selection()


func _on_Leaderboard_pressed() -> void:
	SceneManager.goto_leaderboard()
