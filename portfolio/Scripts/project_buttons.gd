extends TextureButton

@export var title_label : RichTextLabel
@export var time_label : RichTextLabel
@export var body_label : RichTextLabel

@export var title : String
@export var time : String = ""
@export var body : String

@onready var default_title

signal set_body(body : String)
signal set_hover(content : String)

func _ready():
	default_title = title_label.content

func _on_mouse_entered():
	title_label.text = title
	time_label.visible = true
	emit_signal("set_hover", time)
	emit_signal("set_body", body)


func _on_mouse_exited():
	title_label.text = default_title
	body_label.visible = false
	time_label.visible = false
