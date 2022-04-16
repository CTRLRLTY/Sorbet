extends Panel


onready var label: Label = $Label


func _ready() -> void:
	hide()
	
	RuntimeManager.connect("user_login", self, "show")
	RuntimeManager.connect("user_logout", self, "hide")

	label.text = str(RuntimeManager.points) + " PTS"
