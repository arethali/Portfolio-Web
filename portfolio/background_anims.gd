extends Node

@export var crashed_anim : AnimationPlayer
@export var dp_anim : AnimationPlayer
@export var sparks : AnimationPlayer

func _ready():
	crashed_anim.play("Smoke")
	dp_anim.play("Explode")
	await get_tree().create_timer(8.0).timeout
	print("playing1")
	sparks.play("Spark1")
	await sparks.animation_finished
	print("playing2")
	sparks.play("Spark2")
	await sparks.animation_finished
	print("playing3")
	sparks.play("Spark3")
	await sparks.animation_finished
