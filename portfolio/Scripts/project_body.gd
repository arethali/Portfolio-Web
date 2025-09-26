extends RichTextLabel

#@export var content : String
@export var padding : Vector2
@export var padding_bottom : int

var panel_top_left_corner : Vector2
var panel_x_size : int
var panel_y_size : int

func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes

func _ready():
	visible = false


func _on_panel_x_size(size):
	panel_x_size = size


func _on_panel_y_size(size):
	panel_y_size = size


func _on_set_body(body : String):
	var body_size_x = panel_x_size - padding.x * 2 
	var body_size_y = panel_y_size - padding.y - padding_bottom 
	size = Vector2i(body_size_x, body_size_y)
	visible = true
	position = panel_top_left_corner + padding
	text = body
	var text_size_x = get_content_width()
	var text_size_y = get_content_height()
	#$"../../ColorRect".size = Vector2i(body_size_x, body_size_y)
