extends Control

@export_enum("Projects", "Camera", "Contact", "Other") var button_format: String = ""
@export var buttons : Array[TextureButton]
@export var buttons_container : HBoxContainer
@onready var title = $Title
signal overide_panel_size(h, w)

func _ready():
	match button_format:
		"Projects":
			title.content = "[b]Projects[/b]"
			emit_signal("overide_panel_size", 20, 40)
			add_buttons(buttons)
		"Camera":
			pass
		"Contact":
			pass
		"Other":
			pass
		_:
			pass

func add_buttons(butt_arr : Array):
	for i in butt_arr:
		remove_child(i)
		buttons_container.add_child(i)
		i.visible = true
