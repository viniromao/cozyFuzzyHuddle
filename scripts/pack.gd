extends Node3D

@export var direction = Vector3(1,0,1).normalized()
@export var speed = 3
@export var acceleration = .1
@export var center_mass = Vector3(0,0,0)

var debug_position
var pack_awareness

func _ready():
	direction = Vector3(1,0,1).normalized()
	debug_position = get_child(0)
	pack_awareness = get_child(1)
	
func _process(delta):
	center_mass = get_center_of_objects(get_children())
	debug_position.position = center_mass
	direction = run_from_predator()

func get_center_of_objects(objects):	
	var sum = Vector3.ZERO 
	var count = 0
	for obj in objects:
		sum += obj.position
		count += 1
	if count == 0:
		return Vector3.ZERO 
	return sum / count
	
func run_from_predator():
	var predators_position_array = []
	for index in range($pack_awerenes.get_collision_count()):
		if $pack_awerenes.get_collider(index) != null:
			predators_position_array.append($pack_awerenes.get_collider(index).position)
	return get_run_away_direction(predators_position_array)
	
	
func get_run_away_direction(predators_position_array):
	if predators_position_array.size() == 0:
		return Vector3(1,0,1).normalized()
	var centroid = Vector3()	
	for predator_position in predators_position_array:
		centroid += predator_position
	centroid /= predators_position_array.size()
	var direction = position - centroid
	direction.y = 0
	return direction.normalized()
