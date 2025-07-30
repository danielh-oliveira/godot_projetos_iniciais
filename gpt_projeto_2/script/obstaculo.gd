extends StaticBody3D

class_name Obstaculo

enum tipo {NORMAL, BAIXO}
@export var tipo_do_objeto : tipo = tipo.NORMAL

const SPEED = 10.0

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

func _process(delta: float) -> void:
	if position.z > 10:
		queue_free()

func _physics_process(delta: float) -> void:
	position.z += SPEED * delta
	pass
