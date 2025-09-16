extends Node

@export var big_particles : GPUParticles2D
@export var small_particles : GPUParticles2D

@export var home_pos : Vector2
@export var projects_pos : Vector2
@export var personal_pos : Vector2

func _ready():
	pos_parts(home_pos)

func _on_projects_pressed():
	pos_parts(projects_pos)

func _on_personal_pressed():
	pos_parts(personal_pos)

func pos_parts(pos : Vector2):
	big_particles.position = pos
	small_particles.position = pos


func _on_back_pressed():
	pos_parts(home_pos)
