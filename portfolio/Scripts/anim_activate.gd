extends AnimatedSprite2D

@export var anim_player : AnimationPlayer
@export var anim_player_2 : AnimationPlayer
@export var on_anim : String
@export var off_anim : String

@onready var on_off = false

@export var one_shot : bool = false
@export var reversed : bool = false

func _ready():
	if off_anim:
		anim_player.play(off_anim)
	else:
		anim_player.play("RESET")
		if anim_player_2:
			anim_player_2.play("RESET")

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if on_off == false:
					anim_player.play(on_anim)
					if anim_player_2:
						anim_player_2.play(on_anim)
					if one_shot == false:
						on_off = !on_off
				else:
					if reversed == true:
						anim_player.play_backwards(on_anim)
					else:
						if off_anim:
							anim_player.play(off_anim)
							if anim_player_2:
								anim_player_2.play(off_anim)
					on_off = !on_off
