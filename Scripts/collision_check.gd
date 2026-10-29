extends Area3D

signal score_increment(n:int)	#0-Player  1-Enemy

@export var this_is_player_side:bool

func _ready() -> void:
	body_entered.connect(on_body_entered)
	if not score_increment.is_connected(GameManager.update_score):
		score_increment.connect(GameManager.update_score)
	
func on_body_entered(body:Node3D)->void:
	if(not body.is_in_group("ball")):
		return
	score_increment.emit(1 if this_is_player_side else 0)
