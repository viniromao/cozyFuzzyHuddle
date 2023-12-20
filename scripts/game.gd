extends Node3D

const PREDATOR_SPAWN_RADIUS = 50
const MIN_ENVIROMENT_SPAWN_RADIUS = 200

var creature_load = load("res://packed_scenes/creature.tscn")
var pack_load = load("res://packed_scenes/pack.tscn")
var predator_load = load("res://packed_scenes/predator.tscn")
var tree_load = load("res://packed_scenes/trees.tscn")
var stone_load = load("res://packed_scenes/stones.tscn")
var snowman_load = load("res://packed_scenes/snowmans.tscn")
var grass_load = load("res://packed_scenes/grass.tscn")

func _ready():
	instantiate_pack()
	generate_creatures()
	generate_eviroment()

func generate_creatures():
	for i in range(20):
		var creature_instance = creature_load.instantiate() as RigidBody3D	
		var random_position_x = randf_range(-10.0, 10.0)
		var random_position_z = randf_range(-10.0, 10.0)
		creature_instance.position.x = random_position_x
		creature_instance.position.z = random_position_z
		creature_instance.position.y = 0.5
		$pack.add_child(creature_instance)
		
func create_predator():
	var predator_instance = predator_load.instantiate()
	predator_instance.position = $pack.center_mass
	var random_position_x = 0
	var random_position_z = 0

	while abs(random_position_x) < 0.1:  
		random_position_x = PREDATOR_SPAWN_RADIUS * randf_range(-1, 1)

	while abs(random_position_z) < 0.1:  
		random_position_z = PREDATOR_SPAWN_RADIUS * randf_range(-1, 1)
	predator_instance.position.x += random_position_x
	predator_instance.position.z += random_position_z
	predator_instance.position.y = 0.5
	add_child(predator_instance)
		
func instantiate_pack():
	var pack_instance = pack_load.instantiate()
	add_child(pack_instance)
	$player.set_pack_node(pack_instance)


func _on_predator_spawn_timer_timeout():
	create_predator()
	
func generate_eviroment():
	for i in range(1000):
		var tree_instance = tree_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		tree_instance.position.x = random_position_x
		tree_instance.position.z = random_position_z
		tree_instance.position.y = 0
		tree_instance.rotation_degrees.y += randf_range(0, 180)
		add_child(tree_instance)
	for i in range(100):
		var tree_instance = tree_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		tree_instance.get_node("Mesh_Tree_Fir").visible = false
		tree_instance.get_node("Mesh_Tree_Secamore").visible = true
		tree_instance.position.x = random_position_x
		tree_instance.position.z = random_position_z
		tree_instance.position.y = 0
		tree_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(tree_instance)
	for i in range(500):
		var stone_instance = stone_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		stone_instance.position.x = random_position_x
		stone_instance.position.z = random_position_z
		stone_instance.position.y = 0
		stone_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(stone_instance)
	for i in range(1000):
		var stone_instance = stone_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		stone_instance.get_node("Mesh_Stone_Double").visible = false
		stone_instance.get_node("Mesh_Stone").visible = true
		stone_instance.position.x = random_position_x
		stone_instance.position.z = random_position_z
		stone_instance.position.y = 0
		stone_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(stone_instance)
	for i in range(1000):
		var stone_instance = stone_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		stone_instance.get_node("Mesh_Stone_Double").visible = false
		stone_instance.get_node("Mesh_Stone").visible = false
		stone_instance.get_node("Mesh_Stone_Triple").visible = true
		stone_instance.position.x = random_position_x
		stone_instance.position.z = random_position_z
		stone_instance.position.y = 0
		stone_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(stone_instance)
	for i in range(50):
		var snowman_instance = snowman_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		snowman_instance.get_node("Mesh_Snowman").visible = false
		snowman_instance.get_node("Mesh_Snowman_ConeHat").visible = false
		snowman_instance.get_node("Mesh_Snowman_Punk").visible = true
		snowman_instance.position.x = random_position_x
		snowman_instance.position.z = random_position_z
		snowman_instance.position.y = 0
		snowman_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(snowman_instance)
	for i in range(50):
		var snowman_instance = snowman_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		snowman_instance.get_node("Mesh_Snowman").visible = false
		snowman_instance.get_node("Mesh_Snowman_ConeHat").visible = true
		snowman_instance.get_node("Mesh_Snowman_Punk").visible = false
		snowman_instance.position.x = random_position_x
		snowman_instance.position.z = random_position_z
		snowman_instance.position.y = 0
		snowman_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(snowman_instance)
	for i in range(50):
		var snowman_instance = snowman_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		snowman_instance.get_node("Mesh_Snowman").visible = true
		snowman_instance.get_node("Mesh_Snowman_ConeHat").visible = false
		snowman_instance.get_node("Mesh_Snowman_Punk").visible = false
		snowman_instance.position.x = random_position_x
		snowman_instance.position.z = random_position_z
		snowman_instance.position.y = 0
		snowman_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(snowman_instance)
	for i in range(7000):
		var grass_instance = grass_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		grass_instance.get_node("Mesh_Grass_Inwards").visible = true
		grass_instance.get_node("Mesh_Grass_Outwards").visible = false
		grass_instance.position.x = random_position_x
		grass_instance.position.z = random_position_z
		grass_instance.position.y = 0
		grass_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(grass_instance)
	for i in range(7000):
		var grass_instance = grass_load.instantiate()
		var random_position_x = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5,  5)
		var random_position_z = generate_random_number(MIN_ENVIROMENT_SPAWN_RADIUS, 0.5, 5)
		grass_instance.get_node("Mesh_Grass_Inwards").visible = false
		grass_instance.get_node("Mesh_Grass_Outwards").visible = true
		grass_instance.position.x = random_position_x
		grass_instance.position.z = random_position_z
		grass_instance.position.y = 0
		grass_instance.rotation_degrees.y += randf_range(0, 180)		
		add_child(grass_instance)
		
			
func generate_random_number(constant, low_cut, radius):
	var random_number = 0
	while abs(random_number) < low_cut:  
			random_number = constant * randf_range(-1, 1)
	if random_number < 0:
		random_number = random_number - radius
	else:
		random_number = random_number + radius
		
	return random_number
