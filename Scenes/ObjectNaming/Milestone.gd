tool

extends CenterContainer

enum MilestoneType {
	EMPTY,
	SUCCESS,
	FAIL,
	FLAG_EMPTY
}

onready var hbox: HBoxContainer = $HBox


func _enter_tree() -> void:
	if Engine.editor_hint:
		clear_milestone()
		add_milestone(MilestoneType.EMPTY)
		add_milestone(MilestoneType.EMPTY)
		add_milestone(MilestoneType.EMPTY)
		add_milestone(MilestoneType.EMPTY)
		add_milestone(MilestoneType.FLAG_EMPTY)


func _ready() -> void:
	if not Engine.editor_hint:
		clear_milestone()


func milestone_count() -> int:
	return get_child_count()


func clear_milestone() -> void:
	for milestone in $HBox.get_children():
		milestone.queue_free()


func add_milestone(milestone_type := MilestoneType.EMPTY) -> void:
	var add_seperator := bool($HBox.get_child_count() % 2)
	
	if add_seperator:
		var seperator := Panel.new()
		var stylebox := StyleBoxFlat.new()
		
		seperator.rect_min_size = Vector2(24, 12)
		
		stylebox.bg_color = Color("#999D9F")
		
		seperator.add_stylebox_override("panel", stylebox)
		seperator.size_flags_vertical = SIZE_EXPAND | SIZE_SHRINK_CENTER
		
		$HBox.add_child(seperator)
	
	var milestone: TextureRect = TextureRect.new()
	
	milestone.texture = _milestone_texture(milestone_type)

	$HBox.add_child(milestone)


func set_milestone_type(idx: int, milestone_type: int) -> void:
	assert($HBox.get_child_count() >= 0 or $HBox.get_child_count() <= idx, "index out of bound")
	
	# series: n * 2 + 1
	
	var milestone_index = idx * 2 
	
	var milestone: TextureRect = $HBox.get_child(milestone_index)
	
	milestone.texture = _milestone_texture(milestone_type)


func _milestone_texture(milestone_type: int) -> Texture:
	var texture : Texture
	
	match milestone_type:
		MilestoneType.EMPTY:
			texture = load("res://Resources/Textures/milestone_empty.png")
		MilestoneType.SUCCESS:
			texture = load("res://Resources/Textures/milestone_success.png")
		MilestoneType.FAIL:
			texture = load("res://Resources/Textures/milestone_fail.png")
		MilestoneType.FLAG_EMPTY:
			texture = load("res://Resources/Textures/milestone_flag_empty.png")
	
	return texture
