extends Node2D

const SCREEN_ALTO= 960
const SCREEN_ANCHO= 600
var gameover = false

var score = 0
var can_score = true

var enemy = preload("res://Scenes/Enemy.tscn")

func _ready():
	$UI/GameOver.hide()
	
func _input(event):
	if gameover and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://Scenes/World.tscn")

func _physics_process(delta):
	$UI/Marcador.text = str(score)

func _on_TimerShot_timeout():
	if !gameover:
		var enemy_instance = enemy.instance()
		enemy_instance.position = Vector2(rand_range(0, SCREEN_ANCHO), 0)
		enemy_instance.connect("score", self, "_on_player_score")
		add_child(enemy_instance)


func _on_player_score():
	# When the player's ship destroys an asteroid increase the score and update
	# the UI to reflect the score change
	if can_score:
		score += 1
		can_score = false
		$UI/Marcador.text = str(score)
		$TimerScore.start()
	


func _on_TimerScore_timeout():
	can_score = true


func _on_SpaceShip_game_over():
	gameover = true
	$UI/GameOver.show()
