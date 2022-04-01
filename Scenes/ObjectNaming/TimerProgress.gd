extends HBoxContainer

signal timeout


onready var timer_bar: TextureProgress = find_node("TimerBar")


func _ready() -> void:
	timer_bar.timer.connect("timeout", self, "_on_timer_timeout")
	
	start()


func start() -> void:
	set_process(true)
	
	timer_bar.timer.start(timer_bar.max_value)


func reset() -> void:
	start()


func end() -> void:
	set_process(false)
	emit_signal("timeout")


func _process(delta: float) -> void:
#	if timer.time_left
	var timer: Timer = timer_bar.timer

	timer_bar.value = timer.time_left
	timer_bar.label.text = str(stepify(timer.time_left, 0.1)).pad_decimals(1)
	


func _on_timer_timeout() -> void:
	end()
