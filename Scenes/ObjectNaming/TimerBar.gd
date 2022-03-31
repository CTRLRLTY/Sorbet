extends TextureProgress

signal timeout


onready var timer: Timer = $Timer


func _ready() -> void:
	start()


func start() -> void:
	set_process(true)
	
	timer.start(max_value)


func end() -> void:
	set_process(false)
	emit_signal("timeout")


func _process(delta: float) -> void:
#	if timer.time_left
	value = timer.time_left


func _on_Timer_timeout() -> void:
	end()
