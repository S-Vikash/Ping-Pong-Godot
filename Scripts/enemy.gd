extends CharacterBody3D

@export var move_speed: float = 4.75
@export var target: RigidBody3D

func _ready() -> void:
	connect_reset_signal()
	
func connect_reset_signal()->void:
	GameManager.reset_level.connect(on_reset_level)
	
func on_reset_level()->void:
	position = GameManager.get_start_point(1)

func _physics_process(_delta: float) -> void:
	var error: float = target.global_position.y - global_position.y			#Calculate the distance to target from enemy(y-axis)
	velocity.y = error * move_speed 		#If farther faster movement, if closer slower movement
	move_and_slide()
	
	
	'''
	If we want const speed for enemy
	
	var error: float = target.global_position.y - global_position.y
    velocity.y = clampf(error * move_speed, -move_speed, move_speed)
    move_and_slide()
	'''
