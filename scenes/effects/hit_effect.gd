extends Node2D
@onready var cpu_particles_2d:CPUParticles2D = $CPUParticles2D

func _ready()->void:
	cpu_particles_2d.one_shot = true

func _on_cpu_particles_2d_finished()->void:
	queue_free()
