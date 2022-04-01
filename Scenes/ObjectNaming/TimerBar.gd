extends TextureProgress

signal timeout


onready var timer: Timer = $Timer
onready var label: Label = $Label 


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
	label.text = str(stepify(timer.time_left, 0.1)).pad_decimals(1)
	


func _on_Timer_timeout() -> void:
	end()
