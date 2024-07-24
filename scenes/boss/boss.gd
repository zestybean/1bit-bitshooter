extends Area2D

@export var enemy_laser_scene: PackedScene

@export var speed: float = 20
@export var armor: int = 50
@export var wave_amplitude: float = 50
@export var wave_frequency: float = 1
@export var can_fire: bool = false
@onready var shoot_sound: AudioStreamPlayer = $ShootSound
@onready var star_particles := $"../StarParticles"

@onready var flash_timer: Timer= $FlashTimer
@onready var fire_timer: Timer= $FireTimer

var time_passed: float = 0
var boss_is_moving: bool = false

signal boss_destroyed
signal boss_moving

# Declare a variable to hold the original modulate color
var original_modulate: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Store the original modulate color
	original_modulate = modulate

func _process(delta: float) -> void:
	time_passed += delta
	boss_moving.emit(boss_is_moving)

	# Horizontal movement
	if position.x < 280:
		boss_is_moving = false
		can_fire = true
		speed = 0.0
		# Vertical wave movement
		position.y = 90 + wave_amplitude * sin(time_passed * wave_frequency)
	
	if boss_is_moving:
		position.x -= speed * delta
	
func _on_body_entered(body: Node2D)->void:
	body.queue_free()
	armor -= 1
	
	# Trigger the flash effect
	flash()
	
	if armor <= 0:
		var world := get_tree().current_scene
		world.score += 50
		boss_destroyed.emit()
		queue_free()
		
func flash() -> void:
	# Change the modulate color to a flash color (e.g., white or red)
	modulate = Color(0.827451, 0.827451, 0.827451, 1)
	
	# Start the timer to revert the color back
	flash_timer.start(0.1) # Adjust the duration as needed

func _on_flash_timer_timeout()->void:
	modulate = original_modulate


func _on_fire_timer_timeout()->void:
	if can_fire:
		shoot_sound.play()
		var world := get_tree().current_scene
		var laser := enemy_laser_scene.instantiate()

		world.add_child(laser)
		laser.position = position # Replace with function body.
		fire_timer.start(0.4)

func _on_enemy_spawner_boss_move_in()->void:
	star_particles.initial_velocity_min = 100
	star_particles.initial_velocity_max = 500
	boss_is_moving = true
