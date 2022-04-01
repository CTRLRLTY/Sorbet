extends HBoxContainer

signal timeout


onready var timer_bar: TextureProgress = find_node("TimerBar")
onready var timer: Timer = timer_bar.timer


func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_timeout")
	
	start()


func start(time_sec := timer_bar.max_value) -> void:
	if time_sec <= 0.0:
		end()
	
		return
	
	set_process(true)
	
	timer.start(time_sec)


func stop() -> void:
	set_process(false)
	
	timer.stop()


func time_left() -> float:
	return timer.time_left



func end() -> void:
	set_process(false)
	emit_signal("timeout")


func _process(delta: float) -> void:
	timer_bar.value = timer.time_left
	timer_bar.label.text = str(stepify(timer.time_left, 0.1)).pad_decimals(1)
	


func _on_timer_timeout() -> void:
	end()
