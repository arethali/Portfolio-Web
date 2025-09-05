extends Control

@onready var home_pos = 1920
@onready var projects_pos = 3840
@onready var personal_pos = 0

func _on_button_pressed():
	$Camera2D.position.x = projects_pos
	#$AnimationPlayer.play("Cam_Home_to_Projects")


func _on_button_2_pressed():
	$Camera2D.position.x = home_pos
	#$AnimationPlayer.play_backwards("Cam_Home_to_Projects")
