extends TileMapLayer

@export var height : int
@export var width : int
@export var override : bool
@export var light_arrow : bool

@onready var white_arrow = %"White Arrow"
@onready var green_arrow = %"Green Arrow"

@export var anim_play : AnimationPlayer
@onready var color_rect = $ColorRect

var arrow_anim : String
var source_id : int = 1
var layer : int = 0
var atlas_coor_array : Array[Vector2i] = [Vector2i(0,0), Vector2i(2,2), Vector2i(4,2), Vector2i(0,2), Vector2i(0,4), Vector2i(2,4), Vector2i(4,4),]
#Top Left (0),Top Mid (1),Top Right (2),Middle (3),Bottom Left (4), Bottom Middle (5),  Bottom Right (6) 

@onready var tile_offset = Vector2(24, 24)
@onready var tile_map = $"."
@onready var arrow_offset = 20

var global_bottom_left
var global_bottom_right
var global_top_left
var global_top_right

signal bot_left(dimes : Vector2)
signal bot_right(dimes : Vector2)
signal top_left(dimes : Vector2)
signal top_right(dimes : Vector2)

signal x_size(size : int)
signal y_size(size : int)

func _ready():
	if override:
		await get_tree().process_frame
	if height < 1:
		print_debug("Set height to positive number")
		return
	if width < 1:
		print_debug("Set height to width number")
		return
	
	var loop_height = height - 1
	var loop_width = width - 1
	var tile_to_place : Vector2i
	for h in range(height):
		for w in range(width):
			match w:
				0:
					match h:
						0:
							tile_to_place = atlas_coor_array[0]
						loop_height:
							tile_to_place = atlas_coor_array[4]
						_:
							tile_to_place = atlas_coor_array[3]
				loop_width:
					match h:
						0:
							tile_to_place = atlas_coor_array[2]
						loop_height:
							tile_to_place = atlas_coor_array[6]
						_:
							tile_to_place = atlas_coor_array[3]
				_:
					match h:
						0:
							tile_to_place = atlas_coor_array[1]
						loop_height:
							tile_to_place = atlas_coor_array[5]
						_:
							tile_to_place = atlas_coor_array[3]
			#print("place w:" + str(w) + "h: " + str(h))
			set_cell(Vector2i(w, h), source_id, tile_to_place)
	#print(_get_bottom_center())
	if light_arrow:
		green_arrow.visible = false
		white_arrow.position = _get_bottom_center()
		arrow_anim = "White"
	else:
		white_arrow.visible = false
		green_arrow.position = _get_bottom_center()
		arrow_anim = "Idle"
	anim_play.play(arrow_anim)


func get_global_dimensions():
	var get_rect = get_used_rect()
	#var get_tile_set = get_tile_set() 
	global_bottom_left = map_to_local(get_rect.position + Vector2i(0, get_rect.size.y))-  Vector2(20, 16)
	global_bottom_right = map_to_local(get_rect.position + get_rect.size) - Vector2(20, 20)
	global_top_left = map_to_local(get_rect.position) - Vector2(16, 16)
	global_top_right = map_to_local(get_rect.position + Vector2i(get_rect.size.x, 0)) - Vector2(16, 16)
	color_rect.size = Vector2i(global_bottom_right.x - global_bottom_left.x, global_bottom_left.y - global_top_left.y) #+ Vector2i(32, 32)
	#print($ColorRect.size)
	#print(global_bottom_left)
	color_rect.position =  global_top_left
	emit_signal("bot_left", global_bottom_left)
	emit_signal("bot_right", global_bottom_right)
	emit_signal("top_left", global_top_left)
	emit_signal("top_right", global_top_right)
	emit_signal("x_size" , global_bottom_right.x - global_bottom_left.x)
	emit_signal("y_size" , global_bottom_left.y - global_top_left.y)
	
func _get_bottom_center():
	get_global_dimensions()
	var center_x = (abs(global_bottom_left.x) + global_bottom_right.x)/2# - 16
	var panel_y = global_bottom_right.y + arrow_offset #- 16
	return Vector2(center_x, panel_y)
	
#func _process(delta):
	#print(get_viewport().get_mouse_position())


func _on_overide_panel_size(h, w):
	height = h
	width = w
