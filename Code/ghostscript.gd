extends CharacterBody3D

const SPEED = 3.0
var player 

@export var turn_speed = 4.0

func _ready():
	player = get_tree().get_nodes_in_group("MovementPractice")[0]

func _process(delta):
	$FaceDirection.look_at(player.global_transform.orgin, Vector3.UP)
	rotate_y(deg_to_rad($FaceDirection.rotation.y * turn_speed))
	$NavigationAgent3D.set_target_position(player.global_transform.origin)
	var velocity1 = ($NavigationAgent3D.get_next_path_position() - transform.origin).normalized() * SPEED * delta
	move_and_collide(velocity1)

func take_damage():
	queue_free()

func _on_hit_player_body_entered(body):
	if body.is_in_group("MovementPractice"):
		get_tree().call_group("MovementPractice", "hurt", 10)
