extends CharacterBody3D

var pack_node
var game_over_load = preload("res://scenes/game_over.tscn") 
var warm_cold_label_load = preload("res://packed_scenes/warm_cold_label.tscn")

var target_position: Vector3 = Vector3()
var moving_towards_click = false
@export var life_points = 5
var speed = .2
var scared_predators = []
var last_movement_direction = Vector3.ZERO
var scaring_predators = false

func _ready():
	var movement_direction = Vector3.ZERO
	last_movement_direction = movement_direction
	$scare.visible = false
	$running.visible = false
	$walking.visible = true
	movement_direction.z += 1
	if !$scare.visible:
			$mesh.visible = false
			$walking.visible = false
			$running.visible = true
	$running.get_node("AnimationPlayer").play("Take 001")
	last_movement_direction = movement_direction
	look_at_global_transform(movement_direction)
	rotate_y(deg_to_rad(180.0))
	

func _process(delta):
	var moved = false
	var movement_direction = Vector3()
	if Input.is_action_pressed('ui_left'):
		movement_direction.x -= 1
		moved = true
	if Input.is_action_pressed('ui_right'):
		movement_direction.x += 1
		moved = true		
	if Input.is_action_pressed('ui_up'):
		moved = true		
		movement_direction.z -= 1
	if Input.is_action_pressed('ui_down'):
		moved = true		
		movement_direction.z += 1
		
	movement_direction = movement_direction.normalized()
	if scaring_predators:
		set_scared_predators(true)		
		position += movement_direction * speed /6
	else:	
		position += movement_direction * speed /1.5
		
	if moved:
		if !$scare.visible:
			$mesh.visible = false
			$walking.visible = false
			$running.visible = true
		$running.get_node("AnimationPlayer").play("Take 001")
		last_movement_direction = movement_direction
		look_at_global_transform(movement_direction)
	else:
		if !$scare.visible:
			$running.visible = false
			$walking.visible = true
		$walking.get_node("AnimationPlayer").play("Take 001")
		look_at_global_transform(last_movement_direction)		
		
	rotate_y(deg_to_rad(180.0))
	
		
	
	

func set_pack_node(given_pack_node):
	pack_node = given_pack_node
	
func look_at_global_transform(direction):
	var target_position = global_transform.origin + direction
	look_at(target_position, Vector3.UP)

func _on_warmth_tick_timeout():
	var warm_cold_label_instance = warm_cold_label_load.instantiate()
	var label = warm_cold_label_instance.get_node("label") as Label
	if (position.distance_to(pack_node.center_mass)) > 6:
		life_points -= 1
		label.text = "Cold"
		label.modulate = Color(0, 0, 1, 1)
		get_parent().add_child(warm_cold_label_instance)
	else:
		life_points += 1
		if life_points > 5:
			life_points = 5
		label.text = "Warm"
		label.modulate = Color(1, 0, 0, 1)		
		get_parent().add_child(warm_cold_label_instance)
		
	if life_points <= 0:
		get_tree().change_scene_to_packed(game_over_load)

func set_scared_predators(scared):
	for predator in scared_predators:
		predator.set_scared(scared)

func _input(event):
	if event.is_action_pressed("scare_predators"):
		$scare.visible = true
		$walking.visible = false
		$running.visible = false
		$scare.get_node("AnimationPlayer").play("Take 001")
		scaring_predators = true
	elif event.is_action_released("scare_predators"):
		$scare.visible = false
		
		scaring_predators = false
		set_scared_predators(false)
		scared_predators.clear()

func _on_collision_area_body_entered(body: Node3D):
	life_points -= 1
	body.queue_free()
	if life_points <= 0:
		get_tree().change_scene_to_packed(game_over_load)

func _on_scaring_predators_area_body_entered(body):
		scared_predators.append(body)

func _on_scaring_predators_area_body_exited(body):
		body.set_scared(false)
		scared_predators.erase(body)
	
