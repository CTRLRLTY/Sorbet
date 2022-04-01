extends Control

signal choice_selected(choice)


onready var choices: GridContainer = $Choices
onready var timer_progress: Control = $TimerProgress


func set_choices(text: PoolStringArray) -> void:
	for idx in range(choices.get_child_count()):
		var choice: Button = choices.get_child(idx)
		
		choice.text = text[idx]


func choice_count() -> int:
	return choices.get_child_count()


func _on_choice_pressed(text) -> void:
	emit_signal("choice_selected", text)

