extends Area2D

const MOVE_SPEED = -400


func _ready():
	$AnimatedSprite.play()

func _process(delta):
	# Move the projectile forward
	position += Vector2(0.0, MOVE_SPEED * delta)
	
	#destruir los disparos al llegar arriba
	if position.y < 50:
		queue_free()
	


func _on_Shot_area_entered(area):
	queue_free()
