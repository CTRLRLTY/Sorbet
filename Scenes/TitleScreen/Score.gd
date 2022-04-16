extends Panel


onready var label: Label = $Label


func _ready() -> void:
	visible = RuntimeManager.login
	
	RuntimeManager.connect("user_login", self, "show")
	RuntimeManager.connect("user_logout", self, "hide")

	label.text = str(RuntimeManager.points) + " PTS"
