extends Panel


func _on_Back_pressed() -> void:
	hide()


func _on_Logout_pressed() -> void:
	RuntimeManager.login = false
	
	hide()
