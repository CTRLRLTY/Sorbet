extends Control

signal choice_selected(choice)
signal passed
signal failed

var answer: String

onready var choices: GridContainer = $Choices
onready var timer_progress: Control = $TimerProgress


func _ready() -> void:
	timer_progress.connect("timeout", self, "_on_timer_timeout")


func choice_count() -> int:
	return choices.get_child_count()


func pause() -> void:
	timer_progress.pause()


func reset() -> void:
	for btn in choices.get_children():
		btn.disabled = false
	
	timer_progress.stop()


func set_choices(text: PoolStringArray) -> void:
	for idx in range(choices.get_child_count()):
		var choice: Button = choices.get_child(idx)
		
		choice.text = text[idx]


func initiate(answer: String, NAME_LIST: Array) -> void:
	var choices := []
	var buf := NAME_LIST.duplicate()
	
	self.answer = answer
	
	for idx in range(choice_count()):
		var i: int = randi() % buf.size()
		
		var oname: String = buf.pop_at(i)
		choices.append(oname)
	
	# Does choices contain one solution?
	if not choices.has(answer):
		# Place the answer randomly
		var answer_index := randi() % choice_count()
		choices[answer_index] = answer
		
	set_choices(choices)
	timer_progress.start()


func _on_choice_pressed(choice) -> void:
	if choice == answer:
		emit_signal("passed")
		
		reset()
	else:
		var timer_decrease := 3.0
		var time_left = timer_progress.time_left()
		var time_sec: float = max(time_left - timer_decrease, 0)
		
		timer_progress.start(time_sec)


func _on_timer_timeout() -> void:
	emit_signal("failed")
