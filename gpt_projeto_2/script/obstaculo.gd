extends StaticBody3D

class_name Obstaculo

enum tipo {NORMAL, BAIXO}
@export var tipo_do_objeto : tipo = tipo.NORMAL

var SPEED = 10


func _process(delta: float) -> void:
	if position.z > 10:
		queue_free()

func _physics_process(delta: float) -> void:
	position.z += SPEED * delta
