extends TextureButton

@export var cam_scroll : ScrollContainer
@export var cam_scroll_bar : VScrollBar
@export var subwindow_title : RichTextLabel
@export var place_image : TextureRect
@export var looky_back : TextureButton
@export var pic_file : String
@export var pic_link : String

signal send_pic_file(file: String)
signal set_link(file: String)

func _on_pressed():
	ButtonsSound.clicked()
	_toggle_buttons(false)
	_toggle_window(true)
	emit_signal("send_pic_file", pic_file)
	emit_signal("set_link", pic_link)

func _toggle_buttons(visiblity : bool):
	cam_scroll.visible = visiblity
	cam_scroll_bar.visible = visiblity

func _toggle_window(visiblity : bool):
	subwindow_title.visible = visiblity
	place_image.visible = visiblity
	looky_back.visible = visiblity


func _on_cam_back_pressed():
	ButtonsSound.hover()
	_toggle_buttons(true)
	_toggle_window(false)


func _on_mouse_entered():
	ButtonsSound.hover()
