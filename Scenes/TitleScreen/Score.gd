extends Panel


func _ready() -> void:
	hide()
	
	RuntimeManager.connect("user_login", self, "show")
	RuntimeManager.connect("user_logout", self, "hide")
