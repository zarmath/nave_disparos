extends Area2D

var move_speed = 100.0



func _ready():
	$AnimatedSprite.play()
	
	
# The score signal is emitted when an asteroid is destroyed by the player
signal score


func _process(delta):
	# Move the asteroid forward
	position += Vector2(0.0, move_speed * delta)

	# If the asteroid moves beyond the left of our screen we destroy it
	if position.x <= -8:
		queue_free()




func _on_Enemy_area_entered(area):
	emit_signal("score") #para aumentar el marcador
	queue_free()

		
