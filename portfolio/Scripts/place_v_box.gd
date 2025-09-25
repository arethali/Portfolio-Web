extends VBoxContainer

@export var side_padding : int
@export var top_padding : int

var panel_top_left_corner : Vector2
var panel_x_size : int
var panel_y_size : int

func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes

func _ready():
	await get_tree().process_frame
	position = panel_top_left_corner + Vector2(side_padding, top_padding)
	if size.x > panel_x_size:
		print_debug("Panel too thin")
	if size.y > panel_y_size:
		print_debug("Panel too short")

func _on_panel_x_size(size):
	panel_x_size = size


func _on_panel_y_size(size):
	panel_y_size = size
