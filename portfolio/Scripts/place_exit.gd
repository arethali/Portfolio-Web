extends TextureButton

@export var padding : Vector2
var panel_top_right_corner : Vector2


func _on_panel_top_right(dimes):
	panel_top_right_corner = dimes + Vector2(-36, -4)

func _ready():
	position = panel_top_right_corner + padding
