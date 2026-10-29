extends Control

@onready var game_over_label: Label = $Game_Over_Panel/Game_over_label
@onready var game_over_panel: Panel = $Game_Over_Panel
@onready var quit_button: Button = $Game_Over_Panel/VBoxContainer/Quit_Button
@onready var retry_button: Button = $Game_Over_Panel/VBoxContainer/Retry_Button

#Score
@onready var player_score_label: Label = $Player_score_label
@onready var enemy_score_label: Label = $Enemy_score_label


func _ready() -> void:
	game_over_panel.hide()
	GameManager.show_game_over.connect(on_game_over)
	GameManager.score_updated.connect(update_score)

	
func on_game_over(n:int)->void:
	game_over_panel.show()
	if(n==0):
		game_over_label.text = "Player Won!"
	else:
		game_over_label.text = "Player Lost!" 
	
	
func show_gameover_panel()->void:
	game_over_panel.show()

func update_score(n:int)->void:
	if n==0:#Player
		player_score_label.text = "Player: " + str(GameManager.get_score(0))
	else:
		enemy_score_label.text = "Enemy: " + str(GameManager.get_score(1))

func _on_retry_button_pressed() -> void:
	GameManager.reload_level()
	game_over_panel.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
