extends TextureButton

@export var title_label : RichTextLabel
@export var body_label : RichTextLabel

@export var title : String
@export var body : String

@onready var default_title

signal set_body(body : String)

func _ready():
	default_title = title_label.content

func _on_mouse_entered():
	title_label.text = "[b]" + title + "[/b]" 
	emit_signal("set_body", body)


func _on_mouse_exited():
	title_label.text = default_title
	body_label.visible = false
