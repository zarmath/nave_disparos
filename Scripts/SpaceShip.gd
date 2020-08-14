extends KinematicBody2D

export var speed = 200
var can_shoot = true
var screen_size 
var shot_scene = preload("res://Scenes/Shot.tscn")
#var posicionSpaceShip = Vector2()

const MAX_SPEED = 800
const ACCELERATION = 400
const FRICTION = 1000

var velocity = Vector2.ZERO

signal game_over

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") -  Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #Esto hace que se mueva a la misma velocidad cuando se mueva en diagonal 
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #añade cierto frenado al parar el objeto

	velocity = move_and_slide(velocity)
	
	#impedimos qeu la nave se salga de la pantalla
	if position.y > screen_size.y:
		#velocity = velocity.move_toward(Vector2.ZERO,0)
		position.y = screen_size.y
	elif position.y < 0:
		position.y = 0
	
	if position.x > screen_size.x:
		#velocity = velocity.move_toward(Vector2.ZERO,0)
		position.x = screen_size.x
	elif position.x < 0:
		position.x = 0	
	
	
	
	#Disparo
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage_node = get_parent()
		
		
		# Create left projectile
		var shot_top = shot_scene.instance()
		shot_top.position = position + Vector2(-10, -20)
		stage_node.add_child(shot_top)
		
		# Create lower projectile
		var shot_bottom = shot_scene.instance()
		shot_bottom.position = position + Vector2(10, -20)
		stage_node.add_child(shot_bottom)
	
		# Disallow shooting until the reload timer finishes
		can_shoot = false
		get_node("ReloadTimer").start()







func _on_ReloadTimer_timeout():
	can_shoot = true


func _on_Area2D_area_entered(area):
	emit_signal("game_over")
	queue_free()
