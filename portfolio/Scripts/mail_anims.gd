extends AnimatedSprite2D

@export var anim_tree : AnimationTree
@export var anim_player : AnimationPlayer
@export var letter_1 : Area2D
@export var letter_2 : Area2D
var in_anim = false
@onready var first_open = false
@onready var open = false
@onready var interact_area = $"../../Buttons/Mail Box"

@export var paper : Sprite2D

func _ready():
	if paper:
		paper.hide()
	#open_input.hide()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_toggle_contact()


func _on_exit_pressed():
	_toggle_contact()


func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if interact_area.visible == false:
				_toggle_contact()

func _toggle_contact():
	if in_anim == true:
		if open == true:
			anim_tree.get("parameters/playback").travel("Closed")
		else: 
			anim_tree.get("parameters/playback").travel("Open")
	if first_open == false:
		open = true
		first_open = true
		in_anim= true
		anim_tree.set("parameters/conditions/first_open", true)
		await get_tree().create_timer(1.4).timeout
		anim_tree.set("parameters/conditions/first_open", false)
		in_anim= false
		#open = true
		#open_input.show()
		#open_input.disabled = false
		if paper:
			paper.show()
			letter_1.show()
			letter_2.show()
		return
	if open == true:
		open = false
		#print("click")
		in_anim= true
		anim_tree.set("parameters/conditions/Close", true)
		await get_tree().create_timer(.6).timeout
		anim_tree.set("parameters/conditions/Close", false)
		in_anim= false
		#open_input.hide()
		#open_input.disabled = true
		return
	else:
		open = true
		in_anim= true
		anim_tree.set("parameters/conditions/Open", true)
		await get_tree().create_timer(.6).timeout
		anim_tree.set("parameters/conditions/Open", false)
		in_anim= false
		#open_input.show()
		#open_input.disabled = false
		return
	print_debug("Mailbox error")
