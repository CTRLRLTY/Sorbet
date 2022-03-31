tool

extends Button

export var ui_icon: Texture setget set_ui_icon
export var ui_text: String setget set_ui_text
export var ui_font_color: Color setget set_ui_font_color


func set_ui_icon(texture: Texture) -> void:
	var texture_rect: TextureRect = find_node("TextureRect")
	ui_icon = texture
	
	texture_rect.texture = texture
	texture_rect.visible = texture != null


func set_ui_text(t: String) -> void:
	ui_text = t
	find_node("Label").text = t


func set_ui_font_color(color: Color) -> void:
	ui_font_color = color
	
	find_node("Label").add_color_override("font_color", color)
