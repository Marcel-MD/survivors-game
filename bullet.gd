extends Area2D

const IMPACT = preload("res://pistol/impact/impact.tscn")
const SPEED = 1000
const RANGE = 1200
var travelled_distance = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()	


func _on_body_entered(body):
	queue_free()
	var impact = IMPACT.instantiate()
	get_parent().add_child(impact)
	impact.global_position = global_position
	
	if body.has_method("take_damage"):
		body.take_damage()
