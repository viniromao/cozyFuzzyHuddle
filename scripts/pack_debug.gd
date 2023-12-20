extends MeshInstance3D

var pack_node

func _ready():
	pack_node = get_parent()

func _process(delta):
	position += pack_node.direction * pack_node.speed * delta
