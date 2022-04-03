extends HBoxContainer

signal timeout


onready var timer_bar: TextureProgress = find_node("TimerBar")
onready var timer: Timer = timer_bar.timer


func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_timeout")


func start(time_sec := timer_bar.max_value) -> void:
	if time_sec <= 0.0:
		end()
	
		return
	
	set_process(true)
	
	timer.start(time_sec)
	
	print_debug("countdown start %s" % time_sec)


func stop() -> void:
	timer.stop()
	
	print_debug("countdown stop")


func time_left() -> float:
	return timer.time_left


func pause() -> void:
	set_process(false)
	
	timer.paused = true
	
	print_debug("countdown pause at %s" % time_left())

func end() -> void:
	timer.stop()
	
	emit_signal("timeout")
	
	print_debug("countdown ended %s" % time_left())


func _process(delta: float) -> void:
	timer_bar.value = time_left()
	
	timer_bar.label.text = str(stepify(timer.time_left, 0.1)).pad_decimals(1)
	
	if time_left() <= 0:
		set_process(false)


func _on_timer_timeout() -> void:
	end()
