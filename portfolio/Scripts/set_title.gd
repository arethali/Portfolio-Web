extends RichTextLabel

@export var content : String
@export var padding : Vector2

var panel_top_left_corner : Vector2
var panel_x_size : int
var panel_y_size : int

func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes

func _ready():
	await get_tree().process_frame
	position = panel_top_left_corner + padding
	text = content
	var text_size_x = get_content_width()
	var text_size_y = get_content_height()
	#$"../ColorRect".size = Vector2i(text_size_x, text_size_y)

func _on_panel_x_size(size):
	panel_x_size = size


func _on_panel_y_size(size):
	panel_y_size = size
