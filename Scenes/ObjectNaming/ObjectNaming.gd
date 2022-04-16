extends Control

# Equal RNG Bagging algorithm
class RNGBagSlot:
	var item_bag : Array
	var _unique_items := []
	
	func _init(item_list : Array) -> void:
		item_bag = []
		_unique_items = item_list

#########    THIS SECTION IS MODIFIABLE
		_add_equal(item_list)
	
	func _add_equal(item_list : Array) -> void:
		for item in item_list:
		   #########   THIS IS OPTIONAL
			# The amount (3) can be change to N for either less/more rebalancing.
			# This controls the depth.
			for _i in range(3):
				item_bag.push_back(item)

	func get_random_item():
		var selected_item = item_bag[randi() % item_bag.size()]
		
		item_bag.erase(selected_item)

		if item_bag.count(selected_item) <= 1:
			 # Bag rebalancing
			item_bag.append_array(_unique_items)
			
		return selected_item


const NAME_LIST := [
	"cow",
	"dog",
	"horse",
	"chicken",
	"duck",
	"sheep",
	"cat",
	"rabbit",
]


var object_name: String

var milestone_position := 0 setget set_milestone_position
var milestone_steps := 5
var milestone_step_point := 10


var _name_bag: RNGBagSlot


onready var object_rect: TextureRect = $ObjectRect
onready var modes: Control = $Modes
onready var milestone: Control = $Milestone
onready var centered_dialog: Control = $CenteredDialog
onready var buttons: Control = $BottomButtons


func _ready() -> void:
	RuntimeManager.point_accumulated = 0
	
	_name_bag = RNGBagSlot.new(NAME_LIST)
	
	modes.connect("passed", self, "_on_passed")
	modes.connect("failed", self, "_on_failed")
	
	buttons.connect("quit_request", self, "_on_quit_request")
	
	centered_dialog.connect("quit", self, "_on_quit")
	centered_dialog.connect("menu", self, "_on_menu")
	centered_dialog.connect("play_again", self, "_on_play_again")
	
	for step in range(milestone_steps):
		milestone.add_milestone(milestone.MilestoneType.EMPTY)
	
	milestone.set_milestone_type(milestone_steps - 1, milestone.MilestoneType.FLAG_EMPTY)
	
	randomize()
	randomize_object()
	
	modes.play_random(object_name, NAME_LIST)


func _exit_tree() -> void:
	RuntimeManager.flush_accumulated_points()


func randomize_object() -> void:
	var TEX_DIR := "res://Resources/Animals/"
	
	object_name = _name_bag.get_random_item()
	
	var res_path := TEX_DIR + object_name + ".png"
	var texture: Texture = load(res_path)
	
	object_rect.texture = texture


func set_milestone_position(pos: int) -> void:
	milestone_position = pos
	var flag_reached := milestone_position == milestone_steps
	
	if flag_reached:
		centered_dialog.popup_over_dialog()
		
		modes.pause()
	else:
		randomize_object()
		
		modes.play_random(object_name, NAME_LIST)


func _on_quit_request() -> void:
	centered_dialog.popup_quit_dialog()


func _on_passed() -> void:
	milestone.set_milestone_type(milestone_position, 
		milestone.MilestoneType.SUCCESS)
	
	RuntimeManager.point_accumulated += milestone_step_point
	
	self.milestone_position += 1


func _on_failed() -> void:
	milestone.set_milestone_type(milestone_position, 
		milestone.MilestoneType.FAIL)
	
	RuntimeManager.point_accumulated -= milestone_step_point
	
	self.milestone_position += 1


func _on_play_again() -> void:
	get_tree().reload_current_scene()


func _on_quit() -> void:
	SceneManager.goto_level_selection()


func _on_menu() -> void:
	SceneManager.goto_title_screen()
