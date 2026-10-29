extends CharacterBody3D

@export var move_speed:float = 5
var move_dir:float

func _ready() -> void:
	connect_reset_level()
	
func connect_reset_level()->void:
	GameManager.reset_level.connect(on_reset_level)
	
func on_reset_level()->void:
	position = GameManager.get_start_point(0)

func _physics_process(_delta: float) -> void:
	move_dir = Input.get_axis("down","Up")
	velocity.y = move_dir * move_speed
	
	move_and_slide()
	
