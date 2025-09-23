extends RichTextLabel

@export var title : String
@export var padding : Vector2

var panel_top_left_corner : Vector2

func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes

func _ready():
	position = panel_top_left_corner + padding
	text = title
