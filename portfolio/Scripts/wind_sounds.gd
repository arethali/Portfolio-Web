extends AudioStreamPlayer

func _ready():
	if Audio.audio_on != true:
		return
	play()



func _on_mute_paused():
	stop()

func _on_mute_played():
	play()


func _on_play_played():
	play()
