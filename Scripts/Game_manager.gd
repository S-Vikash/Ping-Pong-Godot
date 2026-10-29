extends Node

signal show_game_over(n:int) #0-Player won   1-Enemy won
signal score_updated(n:int)
signal reset_level


var game_over: bool = false

#Score system
@export var max_score:int = 3
var _player_score:int = 0
var _enemy_score:int = 0

@export_group("Spawn Points")
@export var _player_start_point:Vector3 = Vector3(-3,0,0)
@export var _enemy_start_point:Vector3 = Vector3(3,0,0)
@export var _ball_start_point:Vector3 = Vector3.ZERO

func _ready() -> void:
	connect_collision_signals()
	
func connect_collision_signals() -> void:
	var walls = get_tree().get_nodes_in_group("Scored")

	for w in walls:
		if not w.score_increment.is_connected(update_score):
			w.score_increment.connect(update_score)


func update_score(n:int)->void:
	if(n==0):
		_player_score += 1
	else:
		_enemy_score += 1
	
	score_updated.emit(n)
	if(not check_game_over()):
		restart_level()
	
		
func check_game_over()->bool:
	if(_player_score == max_score || _enemy_score == max_score):
		game_over = true
		show_game_over.emit(0 if _player_score > _enemy_score else 1)
		get_tree().paused = true
		return true
	return false

func get_start_point(n:int)->Vector3:
	if(n==1):
		return _enemy_start_point
	elif(n==0):
		return _player_start_point
	else:
		return _ball_start_point

func get_score(n:int)->int:
	if(n==0):#Player
		return _player_score
	else:
		return _enemy_score

func reset_score()->void:
	_enemy_score = 0
	_player_score = 0

func restart_level():
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	reset_level.emit()
	
	
func reload_level() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	reset_score()

	await get_tree().process_frame

	connect_collision_signals()
