extends Control

@export_enum("Text", "Buttons", "Bios", "Resume", "Skills") var format: String
@export var panel : Panel 
@export var click_box : Area2D
@onready var text = %Text
@onready var buttons = %Buttons
@onready var resume = %Resume
@onready var skills = %Skills
@onready var bios = %Bios

var panel_size_x 
var panel_size_y 

func _ready():
	match format:
		"Text":
			text.visible = true
		"Buttons":
			buttons.visible = true
		"Resume":
			resume.visible = true
		"Skills":
			skills.visible = true
		"Bios":
			bios.visible = true
		_:
			print_debug("No format selected.")
			return
	position = Vector2(position.x - (panel_size_x/2), position.y - panel_size_y)
func _on_exit_pressed():
	if visible == true:
		visible = false
		panel.visible = false
		click_box.visible = true

func _show_window():
	if visible == false:
		visible = true
		panel.visible = true
		click_box.visible = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_show_window()
			

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_on_exit_pressed()


func _on_panel_x_size(size):
	panel_size_x = size


func _on_panel_y_size(size):
	panel_size_y = size
