extends Control

var panel_top_left_corner
var panel_x_size
var panel_y_size
var cont_set = false

var min_size : Vector2
var set_rand = false
@export var max_about_line_count : int = 4
@export var padding_sides : Vector2
@export var padding_vert : Vector2

@export var texture : Texture2D
@export var Title_text : String
@export_multiline var about_text : String
@export_multiline var list_1_text : String
@export_multiline var list_2_text : String
@export var top_line_clipped = false

@onready var container = %Container
@onready var first_row = %"First Row"
@onready var second_row = %"Second Row"
@onready var portrait = %Portrait
@onready var about = %About
@onready var list_1 = %List1
@onready var list_2 = %List2
@onready var scroll_container = %ScrollContainer
@onready var about_overflow = %"About Overflow"
@onready var bios = %Bios
@onready var panel = $"../Panel"

signal set_scroll
func _ready():
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

	list_1.text = list_1_text
	list_2.text = list_2_text
	#await get_tree().process_frame
	#first_row.visible = true
	#second_row.visible = true
	

func _on_panel_x_size(size):
	panel_x_size = size

func _on_panel_y_size(size):
	panel_y_size = size
	
func _on_panel_top_left(dimes):
	panel_top_left_corner = dimes

#DO NOT USE BBCS IN TEXT, FUCKS WITH THE COUNTING OR SOMETHING
func _check_overflow():
	await get_tree().process_frame
	var lines_array : Array[String]
	var prev_line = 0
	var string_to_add = ""
	var total_lines = about.get_line_count()
	if total_lines > max_about_line_count:
		#await get_tree().process_frame
		for i in range(about_text.length()+1):
			var current_line = about.get_character_line(i)
			if i == about_text.length():
				lines_array.append(string_to_add)
				break
			if current_line > prev_line:
				lines_array.append(string_to_add)
				string_to_add = ""
				prev_line = current_line
			string_to_add += about.text[i]
		if top_line_clipped == true:
			max_about_line_count -= 1
		about.text = Title_text + "\n" + _stringify_array(0, max_about_line_count, lines_array)
		about_overflow.visible = true
		about_overflow.text = _stringify_array(max_about_line_count, lines_array.size(), lines_array)
		set_rand = false
		return
	about.text = Title_text + "\n" + about_text
	about_overflow.text = ""
	about_overflow.visible = false
	set_rand = false

func _stringify_array(start : int, end : int, array : Array[String]):
	var string = ""
	var pos = start
	var bcc_add_pos = 0
	for i in range(end-start):
		string += array[pos]
		pos += 1
	return string
	
func _on_container_resized():
	if bios and cont_set == false and visible == true:
		cont_set = true
		await get_tree().process_frame
		_check_overflow()
		await get_tree().process_frame
		emit_signal("set_scroll")
		return


func _on_set_rand_text(rand_text):
	about_text = rand_text
	about.text = about_text
	if set_rand == false and cont_set == true:
		set_rand = true
		about_text = rand_text
		about.text = about_text
		_check_overflow()
		await get_tree().process_frame
		emit_signal("set_scroll")
		await get_tree().process_frame
		
		
		
