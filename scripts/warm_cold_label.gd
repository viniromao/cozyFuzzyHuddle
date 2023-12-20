extends Node2D

var speed = 30

func _process(delta):
	position.y -= speed * delta 
	$label.modulate.a -= .03
	
func _on_queue_free_timer_timeout():
	queue_free()
