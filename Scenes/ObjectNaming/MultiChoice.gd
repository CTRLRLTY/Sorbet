extends Control

signal passed
signal failed

var answer: String

onready var choices: GridContainer = $Choices


func choice_count() -> int:
	return choices.get_child_count()


func reset() -> void:
	for btn in choices.get_children():
		btn.disabled = false


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


func _on_choice_pressed(choice) -> void:
	if choice == answer:
		emit_signal("passed")
		
	else:
		emit_signal("failed")
