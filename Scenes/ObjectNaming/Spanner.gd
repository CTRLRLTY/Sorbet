extends PanelContainer


onready var loss: Control = $Loss
onready var gain: Control = $Gain


func _ready() -> void:
	loss.hide()
	gain.hide()


func show_gain() -> void:
	loss.hide()
	gain.show()


func show_loss() -> void:
	gain.hide()
	loss.show()
