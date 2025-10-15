extends Control

var panel_top_left_corner
var panel_x_size
var panel_y_size

var min_size : Vector2
@export var padding_sides : Vector2
@export var padding_vert : Vector2

@export var texture : Texture2D
@export var about_text : String
@export var about_overflow_text : String
@export var list_1_text : String
@export var list_2_text : String
@onready var container = %Container
@onready var first_row = %"First Row"
@onready var second_row = %"Second Row"
@onready var portrait = %Portrait
@onready var about = %About
@onready var list_1 = %List1
@onready var list_2 = %List2
@onready var scroll_container = %ScrollContainer
@onready var about_overflow = %"About Overflow"

signal overide_panel_size(h, w)
signal set_scroll
func _ready():
	emit_signal("overide_panel_size", 20, 30)
	await get_tree().process_frame
	min_size = Vector2((panel_x_size - padding_sides.x - padding_sides.y), (panel_y_size - padding_vert.x - padding_vert.y))
	scroll_container.custom_minimum_size = min_size
	scroll_container.size = min_size
	scroll_container.get_v_scroll_bar().modulate.a = 0
	scroll_container.position = panel_top_left_corner + Vector2(padding_sides.x , padding_vert.x) 
	if texture.get_size() != Vector2(208,288):
		print_debug("Texture not the right size")
		return
	await get_tree().process_frame
	portrait.texture = texture
	about.text = about_text
	_check_overflow()
	list_1.text = list_1_text
	list_2.text = list_2_text
	#await get_tree().process_frame
	#first_row.visible = true
	#second_row.visible = true
	
	print(scroll_container.get_v_scroll_bar().max_value)

func _on_panel_x_size(size):
	panel_x_size = size

func _on_panel_y_size(size):
	panel_y_size = size
	
func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes


func _on_container_resized():
	emit_signal("set_scroll")

func _check_overflow():
	await get_tree().process_frame
	var total_lines = about.get_line_count()
	var visible_lines = about.get_visible_line_count()
	if total_lines > visible_lines:
		if about_overflow_text == "":
			print_debug("Text Overflow")
			return
		about_overflow.text = about_overflow_text
		#print_debug("Text Overflow")
		
