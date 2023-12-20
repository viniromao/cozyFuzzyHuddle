extends RigidBody3D

const MIN_DISTANCE = 7
const MAX_DISTANCE = 9
const COMFORT_ZONE = 8 

var velocity = Vector3.ZERO
var damping = 0.1

var pack_node
var fov: ShapeCast3D

func _ready():
	pack_node = get_parent()
	fov = get_child(1)
	$walking.get_node("AnimationPlayer").play("Take 001")
		
func _process(delta):
	pack_node.direction.y = 0
	position += pack_node.direction * pack_node.speed * delta
	look_at_global_transform(pack_node.direction)
	rotate_y(deg_to_rad(180.0))
	
func look_at_global_transform(direction):
	var target_position = global_transform.origin + direction
	look_at(target_position, Vector3.UP)
	
func _physics_process(delta):
	get_near_other_pack_creatures(delta)

func get_near_other_pack_creatures(delta):
	for index in range(fov.get_collision_count()):
		var other_creature = fov.get_collider(index)
		if other_creature and other_creature != self:
			var distance = position.distance_to(other_creature.position)
			var direction_towards_another_creature = (other_creature.position - position).normalized()

			var speed_adjustment = 1.0
			if distance > MIN_DISTANCE and distance < MAX_DISTANCE:
				speed_adjustment = (distance - MIN_DISTANCE) / (COMFORT_ZONE - MIN_DISTANCE)
			
			if distance > MAX_DISTANCE:
				velocity += direction_towards_another_creature * pack_node.acceleration * speed_adjustment * delta
			elif distance < MIN_DISTANCE:
				velocity -= direction_towards_another_creature * pack_node.acceleration * speed_adjustment * delta

			velocity = velocity.lerp(Vector3.ZERO, damping * delta)
			velocity.y = 0
			
			position += velocity * delta


func _on_body_entered(body):
	print("creature body entered")
