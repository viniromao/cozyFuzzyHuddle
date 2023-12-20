extends Camera3D

var hearth_load = load("res://packed_scenes/hearth.tscn")

var player 
var offset = Vector3(0, 20, 50) 
var zoom_speed = 4
var min_size = 20
var max_size = 40
var current_life_hearths = []

func _ready():
	player = get_parent().get_node("player")  

func _process(delta):
	render_hearths()
	if player:
		global_transform.origin = player.global_transform.origin + offset
		look_at(player.global_transform.origin, Vector3.UP)
	if Input.is_action_just_pressed("zoom_in"):
		size -= zoom_speed
		if size < min_size:
			size = min_size
	elif Input.is_action_just_pressed("zoom_out"):
		size += zoom_speed
		if size > max_size:
			size = max_size
		

func render_hearths():
	var life_points = player.life_points
	print(current_life_hearths.size())
	print(life_points)
	while current_life_hearths.size() != life_points:
		var hearth_instance = hearth_load.instantiate() as Node3D
		if current_life_hearths.size() < life_points:
			hearth_instance.position.x = -11.93 + (2 * current_life_hearths.size())
			hearth_instance.position.y = 9.797
			hearth_instance.position.z = -22.104
			current_life_hearths.append(hearth_instance)
			hearth_instance.rotation_degrees.y = randf_range(0, 180)
			add_child(hearth_instance)
		if current_life_hearths.size() > life_points:
			current_life_hearths.pop_front()
			if get_child_count() > 0:
				var last_child = get_child(get_child_count() - 1)
				remove_child(last_child)
				last_child.queue_free()


