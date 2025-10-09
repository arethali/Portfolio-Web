extends CanvasLayer

var audio_on : bool


func _hide_buttons():
	$Button.hide()
	$Button2.hide()
	print("hide")
	
func _on_button_pressed():
	Audio.audio_on = true
	print("on", Audio.audio_on)
	await get_tree().create_timer(.1).timeout
	Loading.load_scene()
	queue_free()
	
	
func _on_button_2_pressed():
	Audio.audio_on = false
	print("off")
	_hide_buttons()
	Loading.load_scene()
	queue_free()
