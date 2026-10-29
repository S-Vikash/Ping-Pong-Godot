extends RigidBody3D

@export var speed: float = 3.0

var move_dir: Vector3

func _ready() -> void:
	launch_ball()
	connect_reset_level()
	
func connect_reset_level()->void:
	GameManager.reset_level.connect(on_reset_level)
	
func on_reset_level()->void:
	position = GameManager.get_start_point(2)
	launch_ball()
	
func launch_ball():
	move_dir.x = [-1, 1].pick_random()
	move_dir.y = randf_range(0.2, 0.8) * get_ver_dir()
	print("Move_dir.y: ",move_dir.y)
	linear_velocity = move_dir.normalized() * speed


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var v := state.linear_velocity
	v.z = 0.0 # keep it on the play plane
	if v.length() > 0.001:
		state.linear_velocity = v.normalized() * speed

func get_ver_dir()->int:
	return 1 if randf()>0.5 else -1
