extends RigidBody3D

@export var scared = false
var changing_scared_state = false
var beign_scared = false

var target_position = Vector3(10, 0, 10)  
var force_strength = 10.0  
var stop_distance = 1.0 
var speed = 3

var player_node

func _ready():
	player_node = get_parent().get_node("player")

func _process(delta):
	target_position = player_node.position
	var direction = (target_position - position).normalized()
	direction = run_scared(direction)
	direction.y = 0

	if scared:
		$running.visible = false
		$walking.visible = true
		$walking.get_node("AnimationPlayer").play("Take 001")
		position += direction * delta * speed /5
	else:	
		$walking.visible = false
		$running.visible = true
		$running.get_node("AnimationPlayer").play("Take 001")
		position += direction * delta * speed
	look_at_global_transform(direction)
	rotate_y(deg_to_rad(180.0))

func run_scared(direction):
	if scared:
		target_position = player_node.position
		return (position - target_position).normalized()
	else:
		return direction


		
func _on_area_3d_body_entered(body):
	body.queue_free()
	queue_free()
	
func look_at_global_transform(direction):
	var target_position = global_transform.origin + direction
	look_at(target_position, Vector3.UP)

func set_scared(is_scared):
	if is_scared == true:
		scared = true
		beign_scared = true
		$exclamation_mark.visible = scared
		if $scared_timer.is_stopped():
			$scared_timer.start()
	else:
		beign_scared = false		
		changing_scared_state = true
		$changer_scare_state.start()

func _on_changer_scare_state_timeout():
	scared = beign_scared
	$exclamation_mark.visible = scared	
	changing_scared_state = false
	if !beign_scared:
		$scared_timer.stop()

func _on_scared_timer_timeout():
	queue_free()
